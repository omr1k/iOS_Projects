//
//  LocalFileManger.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 30/12/2022.
//

import Foundation
import SwiftUI

class LocalFileManger {
    
    static let instance = LocalFileManger()
    private init(){}
    
    // MARK: - Saving Method
    func saveImage(image: UIImage, imageName: String, folderName: String){
        // Create folder if needed
        createFolderIfNeeded(folderName: folderName)
        // get path for image
        guard
            let data = image.pngData(),
            let url = getImageUrl(imageName: imageName, folderName: folderName)
        else { return }
        // save image to path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error Saving Image, \(error)")
        }
    }
    // MARK: - Getting image Method
    func getImage(imageName: String, folderName: String) -> UIImage?{
        guard
            let url = getImageUrl(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path())
        else { return nil }
        return UIImage(contentsOfFile: url.path())
    }
    
    // MARK: - 
    private func createFolderIfNeeded(folderName: String){
        guard let url = getFolderUrl(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path()){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("\(error)")
            }
        }
    }
    
    private func getImageUrl(imageName: String, folderName: String) -> URL?{
        guard let url = getFolderUrl(folderName: folderName)
        else { return nil }
        return url.appendingPathComponent(imageName + ".png")
    }
    
    private func getFolderUrl(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
//        print("Omarurl \(url)")
        return url.appendingPathComponent(folderName)
    }
    
    
    
    
    
}




//    func writeToDocuments(image: UIImage) {
//        let url = getCachesDirectory().appendingPathComponent(UUID().uuidString)
//        if let jpegData = image.jpegData(compressionQuality: 0.8) {
//            try? jpegData.write(to: url, options: [.atomic, .completeFileProtection])
//            imageabsoluteURL = "\(url.absoluteURL)"
//            imageFileNameString = "\(url.lastPathComponent)"
//        }
//    }
