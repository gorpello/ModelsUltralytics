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
    
    @State private var predictions: [Prediction] = []
    
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
            
            if let image = image {
                ImageDisplayView(image: image)
                
                Button {
                    runModel()
                } label: {
                    Text("Run Yolo!")
                }
            } else {
                noImageSelectedView
            }
            
            ForEach(predictions, id: \.self) { predicion in
                Text("\(predicion.label)  (\(predicion.confidence, format: .percent))")
            }
        }
    }
    
    func runModel() {
        guard
            let cgImage = cgImage,
            let model = try? yolov8x_cls(configuration: .init()).model,
            let detector = try? VNCoreMLModel(for: model) else {
            print("Unable to load photo.")
            return
        }
        
        print("Start request")
        let visionRequest = VNCoreMLRequest(model: detector) { request, error in
            predictions = []
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let results = request.results as? [VNClassificationObservation] {
                
                if results.isEmpty {
                    print("No results found.")
                    return
                }
                
                for result in Array(results.prefix(5)) {
                    
                    let identifier = result.identifier
                    let confidence = result.confidence
                    
                    let object = Prediction(
                        label: result.identifier,
                        confidence: result.confidence,
                    )
                    
                    predictions.append(object)
                    
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
