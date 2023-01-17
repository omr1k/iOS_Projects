//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 29/12/2022.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10,
                x: 0, y: 0
            )
            .padding()
        
        
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
            CircleButtonView(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        
    }
}
