//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 03/01/2023.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var imageService: CoinImageService
    let coin: CoinModel
    
    init(coin: CoinModel) {
        _imageService = StateObject(wrappedValue: CoinImageService(coin: coin))
        self.coin = coin
    }
    
    var body: some View {
        VStack{
            if let image = imageService.coinImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    
                
            } else if imageService.coinImage == nil {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.theme.accent)
            } else{
                ProgressView()
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: CoinModel.example())
    }
}
