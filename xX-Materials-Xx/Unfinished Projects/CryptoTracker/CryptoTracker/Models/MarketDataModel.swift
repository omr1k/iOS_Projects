//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 02/01/2023.
//

import Foundation
import SwiftUI

// MARK: -
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: -
struct MarketDataModel: Codable {
    
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
        return ""
    }
    
    static let example = {
        return MarketDataModel(totalMarketCap: ["usd" : 50.0], totalVolume: ["usd" : 51.0], marketCapPercentage: ["btc" : 50.0], marketCapChangePercentage24HUsd: 55.10)
    }
    
}


 
