//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Omar Khattab on 20/11/2022.
//

import Foundation

class Favorites: ObservableObject {
    
    private var resorts: Set<String>
    private let saveKey = "Favorites"

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: saveKey){
            if let decodedItems = try? JSONDecoder().decode(Set<String>.self, from: savedItems){
                self.resorts = decodedItems
                return
            }
        }
        print("noting")
        self.resorts = []
    }
    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

}
