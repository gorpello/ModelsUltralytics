//
//  Created by Gianluca Orpello.
//  Copyright © 2025 Unicorn Donkeys. All rights reserved.
//

import SwiftUI
import PhotosUI
import Vision

struct ContentView: View {
    
    @State private var selectedImage: PhotosPickerItem?
    @State private var image: Image?
    @State private var cgImage: CGImage?
    @State private var detectedObjects: [DetectedObject] = []
    
    
    var noImageSelectedView: some View {
        Image(systemName: "photo.on.rectangle.angled")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .foregroundColor(.gray)
    }
    
    var body: some View {
        VStack {
            PhotosPicker("Select Photo", selection: $selectedImage, matching: .images)
                .onChange(of: selectedImage) {
                    Task {
                        if
                            let loadedImageData = try? await selectedImage?.loadTransferable(type: Data.self),
                            let uiImage = UIImage(data: loadedImageData) {
                            image = Image(uiImage: uiImage)
                            cgImage = uiImage.cgImage
                        }
                    }
                }
            //            .onChange(of: cgImage) {
            //                runModel()
            //            }
            if let image = image {
                ImageDisplayView(image: image)
                    .overlay {
                        ForEach(detectedObjects, id: \.self) { ident in
                            `ObjectOverlayView`(object: ident)
                        }
                    }
                Button {
                    runModel()
                } label: {
                    Text("Run Yolo!")
                }
            } else {
                noImageSelectedView
            }
            
            ForEach(detectedObjects, id: \.self) { obj in
                Text("\(obj.label)  (\(obj.confidence, format: .percent))")
            }
        }
    }
    
    func runModel() {
        guard
            let cgImage = cgImage,
            let model = try? yolov8x_oiv7(configuration: .init()).model,
            let detector = try? VNCoreMLModel(for: model) else {
            print("Unable to load photo.")
            return
        }
        
        let visionRequest = VNCoreMLRequest(model: detector) { request, error in
            detectedObjects = []
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let results = request.results as? [VNRecognizedObjectObservation] {
                
                if results.isEmpty {
                    print("No results found.")
                    return
                }
                
                for result in Array(results.prefix(5)) {
                    
                    if let firstIdentifier = result.labels.first {
                        let confidence = firstIdentifier.confidence
                        let label = firstIdentifier.identifier
                        
                        let boundingBox = result.boundingBox
                        
                        let object = DetectedObject(
                            label: label,
                            confidence: confidence,
                            boundingBox: boundingBox
                        )
                        detectedObjects.append(object)
                    }
                }
            }
        }
        
        visionRequest.imageCropAndScaleOption = .scaleFill
        
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: .up)
        
        do {
            try handler.perform([visionRequest])
        } catch {
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
