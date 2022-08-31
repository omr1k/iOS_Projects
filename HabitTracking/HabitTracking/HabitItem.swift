//
//  HabitItem.swift
//  HabitTracking
//
//  Created by Omar Khattab on 22/08/2022.
//

import Foundation

struct HabitItem: Identifiable,Codable,Equatable{
    var id = UUID()
    let title : String
    let description : String
    var compCount : Int
    
    
    public mutating func incrementAmount() {
            self.compCount += 1
        }
    
    
}

