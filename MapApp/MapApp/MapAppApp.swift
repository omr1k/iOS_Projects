//
//  MapAppApp.swift
//  MapApp
//
//  Created by Omar Khattab on 11/02/2023.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm  = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
