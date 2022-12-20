//
//  ContentView.swift
//  SwiftuiCollective
//
//  Created by Omar Khattab on 20/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Tab = .house
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack{
                TabBar1(selectedTab: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue){ tab in
                        HStack{
                            Image(systemName:  tab.rawValue)
                            Text(tab.rawValue.capitalized)
                                .bold()
                                .animation(nil,value: selectedTab)
                        }
                        .task ( tab)
                    }
                }
            }
            
            
            
            VStack {
                Spacer()
                TabBar1(selectedTab: $selectedTab)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
