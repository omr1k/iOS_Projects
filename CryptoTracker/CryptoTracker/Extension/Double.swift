//
//  Double.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 29/12/2022.
//

import Foundation

extension Double {
    
    /// ```
    /// Covert Double into a currency with 2-6 decimal places
    /// ```
    private var currencyFormatter6: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// ```
    /// Covert Double into a currency with 2-6 decimal places
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00" 
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}
