# Image Detection App  

**Image Detection App** is a SwiftUI application that allows you to select an image from your library and classify it using a Core ML image detection model. Unlike object detection, which identifies and localizes objects, image detection classifies the entire image into a single label.  

> [!WARNING]  
> Due to the size of the model files, I have not included them in the materials. These projects will not compile unless you add the yolo model. Sorry for the inconvenience...

## The Purpose  

Use Core ML to perform image classification tasks, enabling your apps to analyze and categorize images locally on-device.  

## Features  

- Select an image from your photo library.  
- Run the selected image through a Core ML classification model.  
- Display the predicted label and confidence score.  
- (Optional) Compare results across multiple models by letting the user choose which model to use.  

## Exercise  

Your task is to create a new iOS project that uses Core ML for image classification. This will require you to convert or download a pre-trained image classification model, import it into Xcode, and then integrate it into a SwiftUI app that allows the user to select an image and view the results.  

Some possible models to use include:  
- **Ultralytics YOLOv8x-cls**  
- **FastViT**  
- **MobileNetV2**  
- **ResNet50**  

### Requirements  

The project type is a SwiftUI application with at least one main View and shall run on the simulator.  

- The project shall let the user import an image to the app and prominently display it on the main view.  
- The project shall run the selected image through a Core ML image classification model.  
- The app shall display the classification label and confidence score to the user.  
- The app shall run without crashing.  

* For extra credit:  
- Provide multiple models and let the user choose between them to compare performance and accuracy.  
- Display metrics like inference time to evaluate performance.  

## How to Use  

1. **Run the app** in Xcode on a supported Apple platform (iOS or macOS*).  
2. **Select an image** from your library.  
3. Tap **Classify Image** to run the Core ML model.  
4. View the predicted label and confidence score.  
5. (Optional) Switch models and compare results.  

## Requirements  

- Xcode 15 or newer  
- Swift 5.9 or newer  
- SwiftUI  
- Core ML framework  
- iOS 17+ or macOS 14+ (depending on your deployment target)  
- Core ML Tools environment (for converting models, e.g. Conda)  

## Getting Started  

1. Clone the repository.  
2. Convert or download your chosen image classification model(s) to Core ML format.  
3. Import the `.mlmodel` file(s) into your Xcode project.  
4. Select a simulator or device and run.  

## Credits  

Created by Gianluca Orpello.  
Uses Apple’s **Core ML** framework.  

## License  

MIT License. See [LICENSE](LICENSE) for details.  

---  

*Make sure to grant the app access to your Photos library when prompted.*  
