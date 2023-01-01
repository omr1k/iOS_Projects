//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 28/12/2022.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            
            NavigationView(){
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
