//
//  ContentView.swift
//  Moonshot
//
//  Created by Omar Khattab on 19/08/2022.
//

import SwiftUI


struct ContentView: View {

    @State var toggleView = false
    @State private var scale = 1.0
    

    var body: some View {
        NavigationView {
            
            ZStack{
                if toggleView {
                    NativeGridView()
                } else {
                    ListView()
                }
            }
            .transition(.identity)
            .animation(Animation.easeInOut(duration: 0.5), value: toggleView)
//            .animation(.easeInOut)
          
            
            
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            
            .toolbar {
                    Button("Change View") {

                            toggleView.toggle()
                              
                        
                    }
                
            }
            
        }
        
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

