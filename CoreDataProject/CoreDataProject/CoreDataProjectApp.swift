//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Omar Khattab on 09/09/2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
