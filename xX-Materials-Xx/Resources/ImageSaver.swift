//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Omar Khattab on 20/09/2022.
//

import UIKit

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    
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
    
}


// Usage
//Button("Save Image") {
//    guard let inputImage = inputImage else { return }
//
//    let imageSaver = ImageSaver()
//    imageSaver.writeToPhotoAlbum(image: inputImage)
//}
