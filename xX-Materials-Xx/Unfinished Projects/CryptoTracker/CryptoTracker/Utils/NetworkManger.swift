//
//  NetworkManger.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 30/12/2022.
//

import Foundation

@MainActor class NetworkManger: ObservableObject {
    
    ///```
    /// getData
    /// Generic function to fetch data form api, to use it just provide the api endpoint and Decoding Model, valid for decodable types only
    ///```
    
    func getData<T: Codable>(endPoint: String, decodingModel: T.Type) async -> T {
        
        guard let url = URL(string: endPoint)
        else { fatalError("URL Error") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringCacheData
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let (data, _) = try? await URLSession.shared.data(for: request)
        else { fatalError("URL Session Error") }
        
        guard let decodedData = try? decoder.decode(decodingModel.self, from: data)
        else { fatalError("Decoding Error") }
        
        return decodedData
    }
    
    
}






//
//func getCoinsData() async -> [CoinModel] {
//    let endpoint = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
//
//    guard let url = URL(string: endpoint) else { return [] }
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.cachePolicy = .reloadIgnoringCacheData
//    let decoder = JSONDecoder()
//    decoder.dateDecodingStrategy = .iso8601
//    do {
//        let (data, _) = try await URLSession.shared.data(for: request)
//        let decodedData = try decoder.decode([CoinModel].self, from: data)
//        print(decodedData)
//
////            let hyh = await getCoinsData2(endPoint: endpoint, decodingModel: [CoinModel].self)
////            print(hyh)
//
//        return decodedData
//    } catch {
//        print(error)
//    }
//    return []
//}
