//
//  SavePersonData.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 08/10/2022.
//

import Foundation

class SavePersonData : ObservableObject {
    
    @Published var persons = [personData](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(persons){
                UserDefaults.standard.set(encoded,forKey: "persons")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "persons"){
            if let decodedItems = try? JSONDecoder().decode([personData].self,from:savedItems){
                persons=decodedItems
                return
            }
        }
        self.persons  = []
    }
    
}
