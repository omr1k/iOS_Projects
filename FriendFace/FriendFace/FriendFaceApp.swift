//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Omar Khattab on 10/09/2022.
//

import CoreData
import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
