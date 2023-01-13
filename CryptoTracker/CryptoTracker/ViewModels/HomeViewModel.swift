//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 29/12/2022.
//

import Foundation
import SwiftUI
import Combine



@MainActor class HomeViewModel: ObservableObject {
    
    @Published var allFetchedCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var statistics: [StatisticModel] = []
    @Published var searchText: String = ""
    
    private let portfolioDBService = PortfolioDataService()

    var can = Set<AnyCancellable>()
    
    var allCoins: [CoinModel] {
        if !searchText.isEmpty {
            return allFetchedCoins.filter { $0.symbol.localizedCaseInsensitiveContains(searchText) }
        }
        return allFetchedCoins
    }
    
    init(){
        updateCoinData()
        getMarketData()
        subscribers()
    }
    
    func subscribers(){
        
        $allFetchedCoins
            .combineLatest(portfolioDBService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap{ (coin) -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {return nil}
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink{ [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &can)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDBService.updatePortfolio(coin: coin, amount: amount)
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


//    func updatePortCoins(coin: CoinModel){
//        if let coinIN = portfolioService.savedEntities.first(where: {$0.coinID == coin.id}) {
//            coin.updateHoldings(amount: coinIN.amount)
//        }
//    }



//
//func getAllCoins() -> [CoinModel] {
//    for fullCoin in allFetchedCoins {
//        for twoCoin in portClass.savedEntities {
//            if twoCoin.coinID == fullCoin.id {
//                var xxx: [CoinModel] = []
//                xxx.append(fullCoin.updateHoldings(amount: twoCoin.amount))
//                return xxx
//            }
//        }
//
//    }
//    return []
//}
//
//func tes(twoCoinData: [PortfolioEntity]){
//    for fullCoin in allFetchedCoins {
//        for twoCoin in twoCoinData {
//            if twoCoin.coinID == fullCoin.id {
//                portfolioCoins.append(fullCoin.updateHoldings(amount: twoCoin.amount))
//            }
//        }
//
//    }
//}
//
//func updatePortfolio(coin: [PortfolioEntity]){
////        print(PortfolioServiceXX.savedEntities)
////        $allFetchedCoins
////            .combineLatest(PortfolioServiceXX.$savedEntities)
////            .map{ (coinModels,PortfolioEntities) -> [CoinModel] in
////
////                coinModels
////                    .compactMap { (coin) -> CoinModel in
////                        guard let entity = PortfolioEntities.first(where: { $0.coinID == coin.id }) else {
////                            return CoinModel.example()
////                        }
////                        return coin.updateHoldings(amount: entity.amount)
////                    }
////            }
////            .sink{ [weak self] (rC) in
////                self?.portfolioCoins = rC
////            }
////            .store(in: &can)
//}


//func test2(){
//    if !PortfolioServiceXX.savedEntities.isEmpty {
//        for en in PortfolioServiceXX.savedEntities {
//            for cc in allFetchedCoins {
//                if en.coinID == cc.id {
//                    portfolioCoins.append(cc.updateHoldings(amount: en.amount))
//                }
//            }
//        }
//    }
//}


//    func getPortfolioCoinsFromCoreData(allCoinsX: [CoinModel]?) {
//
//        guard let allCoinsX = allCoinsX else {return}
//        for en in PortfolioServiceXX.savedEntities {
//            for cc in allCoinsX {
//                if en.coinID == cc.id {
//                    portfolioCoins.append(cc.updateHoldings(amount: en.amount))
//                    print("======================")
//                    print("\(en.coinID)")
//                    print("\(cc.id)")
//                    print("======================")
//                }
//            }
//        }
//
////        print("============xxxxx=>\(PortfolioDataService().savedEntities[8].amount)")
////        print("============xxxxx=>\(PortfolioDataService().savedEntities)")
//    }

//    var test: [CoinModel]{
//        if !PortfolioServiceXX.savedEntities.isEmpty {
//            for en in PortfolioServiceXX.savedEntities {
//                for cc in allFetchedCoins {
//                    if en.coinID == cc.id {
//
//                    }
//                }
//            }
//        }
//
//
//
//        return [CoinModel.example()]
//    }

//        ForEach(PortfolioServiceXX.savedEntities){ xx in
//
//            ForEach(self.allFetchedCoins){ cc in
//                if cc.id == xx.coinID {
//
//                }
//            }
//
//        }


//        let en = PortfolioServiceXX.savedEntities.first(where: {$0.coinID == })

        
//        ForEach(allCoinsX){ coinxx in
//            if (PortfolioServiceXX.savedEntities.first(where: {$0.coinID == coinxx.id}) != "") {
//                portfolioCoins.append(coinxx.updateHoldings(amount: 6.6))
//            }
//
//        $allFetchedCoins
//            .combineLatest(PortfolioServiceXX.$savedEntities)
//            .map{ (coinModels,PortfolioEntities) -> [CoinModel] in
//
//                coinModels
//                    .compactMap { (coin) -> CoinModel in
//                        guard let entity = PortfolioEntities.first(where: { $0.coinID == coin.id }) else {
//                            return CoinModel.example()
//
//                        }
//                        return coin.updateHoldings(amount: entity.amount)
//                    }
//
//
//            }
//            .sink{ [weak self] (rC) in
//                self?.portfolioCoins = rC
//
//            }
//            .store(in: &can)
            


//        let en = PortfolioServiceXX.savedEntities.first(where: {$0.coinID == })

        
//        ForEach(allCoinsX){ coinxx in
//            if (PortfolioServiceXX.savedEntities.first(where: {$0.coinID == coinxx.id}) != "") {
//                portfolioCoins.append(coinxx.updateHoldings(amount: 6.6))
//            }
//
//        $allFetchedCoins
//            .combineLatest(PortfolioServiceXX.$savedEntities)
//            .map{ (coinModels,PortfolioEntities) -> [CoinModel] in
//
//                coinModels
//                    .compactMap { (coin) -> CoinModel in
//                        guard let entity = PortfolioEntities.first(where: { $0.coinID == coin.id }) else {
//                            return CoinModel.example()
//
//                        }
//                        return coin.updateHoldings(amount: entity.amount)
//                    }
//
//
//            }
//            .sink{ [weak self] (rC) in
//                self?.portfolioCoins = rC
//
//            }
//            .store(in: &can)
//





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
