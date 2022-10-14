//
//  DataController.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 14/10/2022.
//


import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading data \(error.localizedDescription)")
            }
        }
    }
}
