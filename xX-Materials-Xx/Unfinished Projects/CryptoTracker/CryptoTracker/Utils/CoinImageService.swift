//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 31/12/2022.
//

import Foundation
import SwiftUI


class CoinImageService: ObservableObject {
    
    @Published var coinImage: UIImage? = nil
    private let coin: CoinModel
    private let fileManger = LocalFileManger.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    private func getCoinImage(){
        if let savedImage = fileManger.getImage(imageName: imageName, folderName: folderName){
//            print("from our db")
            coinImage = savedImage
            
        } else {
            Task{
               await downloadImage()
//               print("download")
            }
            
        }
        
    }
    
    private func downloadImage() async {
        guard let url = URL(string: coin.image) else { fatalError("URL Error") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringCacheData
        guard let imageData = try? Data(contentsOf: url)
        else { fatalError("URL Error") }
        
        guard let returnedImage = UIImage(data: imageData) else { return}
//        let returnedImage = UIImage(data: imageData)
//        coinImage = UIImage(data: imageData)
        coinImage = returnedImage
        fileManger.saveImage(image: returnedImage, imageName: imageName, folderName: folderName)
    }
}
 






////    private let coin: CoinModel
////    private let folderName = "coinImages"
////    let fileManager = LocalFileManger.instance
//
//    init() {
////        coin = CoinModel.example()
//    }
//
////    private func get(coimm: CoinModel){
////        if let saved = fileManager.getImage(imageName: coimm.id, folderName: folderName){
////            coinImage = saved
////            print("dawnlaod")
////        } else {
////            Task{
////                coinImage = await fetchImage(endPoint: coimm.image)
////            }
////        }
////    }
//
//////    async -> UIImage?
////    func fetchImage(endPoint: String) async {
////        guard let url = URL(string: endPoint) else {
////            fatalError("URL Error")
////        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.cachePolicy = .reloadIgnoringCacheData
//        guard let data = try? Data(contentsOf: url)
//        else { return }
//        coinImage = UIImage(data: data)
//////        return UIImage(data: data)!
////    }
//
//}
//
//
//
//
//
//
////    init(){
//

//        coin = CoinModel.example()
//        coinImage = getImage(imageId: coin.image)
//    }

//    private func getImage(imageId: String) -> UIImage?{
//
//        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
//        else{ return nil }
//        let folderUrl = cacheDirectory.appendingPathComponent(folderName)
//    }






