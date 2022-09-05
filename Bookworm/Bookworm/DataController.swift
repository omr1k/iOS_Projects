//
//  DataController.swift
//  Bookworm
//
//  Created by Omar Khattab on 05/09/2022.
//

import CoreData
import Foundation


class DataController : ObservableObject{
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores{description,error in
            if let error = error {
                print("Core date failed to load \(error.localizedDescription)")
            }
            
        }
    }
    
}
