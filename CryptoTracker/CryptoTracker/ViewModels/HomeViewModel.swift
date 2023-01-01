//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 29/12/2022.
//

import Foundation
import SwiftUI



@MainActor class HomeViewModel: ObservableObject {
    
    @Published var allFetchedCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    var allCoins: [CoinModel] {
        if searchText.isEmpty {
            return allFetchedCoins
        } else {
            return allFetchedCoins.filter { $0.symbol.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init(){
        updateCoinData()
    }
    
    func updateCoinData(){
        let CoinsEndpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        Task{
            allFetchedCoins = await NetworkManger().getData(endPoint: CoinsEndpoint, decodingModel: [CoinModel].self)
        }
    }
    
    
    
}











//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
//            self.allCoins.append(CoinModel.example())
//            self.portfolioCoins.append(CoinModel.example())
//        }


//    func getCoinsData1() async  -> [CoinModel] {
//         let endpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
//
//        let url = URL(string: endpoint)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.cachePolicy = .reloadIgnoringCacheData
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let decodedData = try decoder.decode(CoinModel.self, from: data)
////                allCoins = decodedData
//            print(decodedData)
//            return [decodedData]
//        } catch {
//            print(error)
//        }
//        return []
//    }
