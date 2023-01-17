//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 29/12/2022.
//

import SwiftUI


struct CoinRowView: View {
    
    let coin: CoinModel
    var showHoldingColumn: Bool
        
    var body: some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.SecondaryTextColor)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading)
                .foregroundColor(Color.theme.accent)
            Spacer()
            if showHoldingColumn {
                VStack(alignment: .trailing){
                    Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                        .bold()
                    Text((coin.currentHoldings ?? 0).asCurrencyWith6Decimals())
                }
                .foregroundColor(Color.theme.accent)
            }
            VStack (alignment: .trailing){
                Text(coin.currentPrice.asCurrencyWith6Decimals())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.GreenColor : Color.theme.RedColor
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: CoinModel.example(), showHoldingColumn: true )
    }
}




//    init(coin: CoinModel, showHoldingColumn: Bool) {
//        self.coin = coin
//        self.showHoldingColumn = false
//
//    }




//            AsyncImage(url: URL(string: coin.image), scale: 3) { image in
//                image
//                    .resizable()
//                    .scaledToFit()
//            } placeholder: {
//                ProgressView()
//
//            }
//            .frame(width: 30, height: 30)
//




//            AsyncImage(url: URL(string: coin.image), scale: 3) { CoinImage in
//
//                if let image = CoinImage.image {
//                    image
//                        .resizable()
//                        .scaledToFit()
//                } else if CoinImage.error != nil {
//                    Image(systemName: "questionmark.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(Color.theme.accent)
//                } else {
//                    ProgressView()
//                }
//            }
//            .frame(width: 30, height: 30)
//
            

//        _imageService = StateObject(wrappedValue: CoinImageService(coin: coin))
//    @StateObject var imageService: CoinImageService


//                if let image = imageService.coinImage{
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//
//                } else if imageService.coinImage == nil {
//                    Image(systemName: "questionmark.circle")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(Color.theme.accent)
//                } else{
//                    ProgressView()
//                }
