//
//  NeverForgetNamesApp.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 07/10/2022.
//

import SwiftUI

@main
struct NeverForgetNamesApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
