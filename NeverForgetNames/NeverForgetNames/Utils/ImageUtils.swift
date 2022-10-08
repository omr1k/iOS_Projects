//
//  ImageSaver.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 07/10/2022.
//

import UIKit

class ImageUtils: NSObject {
    
    var imageabsoluteURL = ""
    var imageFileNameString = ""
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first one, which ought to be the only one
        print(paths[0])
        return paths[0]
    }
    
    func writeToDocuments(image: UIImage) {
        let url = getDocumentsDirectory().appendingPathComponent(UUID().uuidString)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
            print(url.absoluteURL)
            imageabsoluteURL = "\(url.absoluteURL)"
            imageFileNameString = "\(url.lastPathComponent)"
            print("\(imageabsoluteURL) ===== \(imageFileNameString)")
        }
    }
    
    func imagePathToShow() -> String {
        return imageabsoluteURL
    }
    func imageFileName() -> String {
        return imageFileNameString
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }
        return nil
    }
    
}


// Usage
//Button("Save Image") {
//    guard let inputImage = inputImage else { return }
//
//    let imageSaver = ImageSaver()
//    imageSaver.writeToPhotoAlbum(image: inputImage)
//}
