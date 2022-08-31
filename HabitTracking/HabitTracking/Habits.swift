//
//  Habits.swift
//  HabitTracking
//
//  Created by Omar Khattab on 22/08/2022.
//

import Foundation

class Habits : ObservableObject {
    
    @Published var items = [HabitItem](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded,forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([HabitItem].self,from:savedItems){
                items=decodedItems
                return
            }
        }
        self.items  = []
    }
    
}


