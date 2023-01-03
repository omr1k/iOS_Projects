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
    @Published var statistics: [StatisticModel] = []
    
    var allCoins: [CoinModel] {
        if !searchText.isEmpty {
            return allFetchedCoins.filter { $0.symbol.localizedCaseInsensitiveContains(searchText) }
        }
        return allFetchedCoins
    }
    
    
    init(){
        updateCoinData()
        getMarketData()
    }
    
    func updateCoinData(){
        let CoinsEndpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        Task{
            allFetchedCoins = await NetworkManger().getData(endPoint: CoinsEndpoint, decodingModel: [CoinModel].self)
        }
    }
    
    
    func getMarketData(){
        let marketDataEndPoint = "https://api.coingecko.com/api/v3/global"
        Task{
            let marketData = await NetworkManger().getData(endPoint: marketDataEndPoint, decodingModel: GlobalData.self)
            
            let marketCap = StatisticModel(title: "Market Cap", value: marketData.data?.marketCap ?? "" , percentageChange: marketData.data?.marketCapChangePercentage24HUsd)
            let volume = StatisticModel(title: "24h Volume", value: marketData.data?.volume ?? "")
            let btcDominance = StatisticModel(title: "BTC Dominance", value: marketData.data?.btcDominance ?? "")
            let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00" , percentageChange: -25.3)
            
            statistics.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
        }
    }
    
    
}






//var allCoins: [CoinModel] {
//    if searchText.isEmpty {
//        return allFetchedCoins
//    } else {
//        return allFetchedCoins.filter { $0.symbol.localizedCaseInsensitiveContains(searchText) }
//    }
//}






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



//
//func getMarketData(){
//    let marketDataEndPoint = "https://api.coingecko.com/api/v3/global"
//    Task{
//        let marketData = await NetworkManger().getData(endPoint: marketDataEndPoint, decodingModel: GlobalData.self)
//        print("\(marketData)")
//    }

//}



//    func getMarketData(){
//        let endPoint = "https://api.coingecko.com/api/v3/global"
//
//        Task{
//            guard let url = URL(string: endPoint)
//            else { fatalError("URL Error") }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.cachePolicy = .reloadIgnoringCacheData
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//
//            guard let (data, _) = try? await URLSession.shared.data(for: request)
//            else { fatalError("URL Session Error") }
//
//            guard let decodedData = try? decoder.decode(GlobalData.self, from: data)
//            else { fatalError("Decoding Error") }
//
//            print("\(decodedData)")
//
////            marketData = decodedData
////            print("=============>>\(decodedData)<<=============")
//
////            let one = StatisticModel(title: "gfg", value: "\(marketData.MarketDataModel?.marketCap)")
//
//            }
//        }


//        let CoinsEndpoint = "https://www.omarkhattab.tk/json/data.json"
