//
//  TabBar1.swift
//  SwiftuiCollective
//
//  Created by Omar Khattab on 20/12/2022.
//

import SwiftUI

enum Tab: String, CaseIterable{
    case house
    case message
    case person
    case leaf
    case gearshape
}

struct TabBar1: View {
    
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    private var TabColor: Color {
        switch selectedTab {
        case .house:
            return .blue
        case .person:
            return .pink
        case .leaf:
            return .green
        case .message:
            return .purple
        case .gearshape:
            return .red
        }
    }
    
   
    
    var body: some View {
        VStack{
            HStack{
                ForEach(Tab.allCases, id: \.rawValue){ tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.5 : 1.0)
                        .foregroundColor(selectedTab == tab ? TabColor : .gray)
                        .font(.title2)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5)){
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct TabBar1_Previews: PreviewProvider {
    static var previews: some View {
        TabBar1(selectedTab:  .constant(.house))
    }
}
