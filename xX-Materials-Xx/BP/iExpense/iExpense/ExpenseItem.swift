//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Omar Khattab on 16/08/2022.
//

import Foundation


struct ExpenseItem: Identifiable,Codable {
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
    let currency : String
}
