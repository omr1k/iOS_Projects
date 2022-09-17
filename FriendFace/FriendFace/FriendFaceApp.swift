//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Omar Khattab on 14/09/2022.
//

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
