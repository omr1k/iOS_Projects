//
//  ContentView.swift
//  Moonshot
//
//  Created by Omar Khattab on 19/08/2022.
//

import SwiftUI


struct ContentView: View {

    @State private var toggleView = false
    @State private var toggleButtontext = "Switch to"
    @State private var scale = 1.0
    

    var body: some View {
        NavigationView {
            ZStack{
                if toggleView {
                    ListView()
                } else {
                    NativeGridView()
                }
            }
            .transition(.identity)
            .animation(Animation.easeInOut(duration: 0.5), value: toggleView)
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button(toggleView ? "\(toggleButtontext) Grid View" : "\(toggleButtontext) List View") {
                            toggleView.toggle()
                    }

            }
            
        }
        .accentColor(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





//            Group {
//                if toggleView {
//                    NativeGridView()
//                } else {
//                    ListView()
//                }
//            }

