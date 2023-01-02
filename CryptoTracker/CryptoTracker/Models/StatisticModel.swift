//
//  StatisticModel.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 02/01/2023.
//

import Foundation

struct StatisticModel: Identifiable {
    
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
    static let example = {
        StatisticModel(title: "Title Omar", value: "$345.133Tr",percentageChange: -23.0)
    }
}
