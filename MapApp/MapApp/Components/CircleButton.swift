//
//  CircleButton.swift
//  MapApp
//
//  Created by Omar Khattab on 16/02/2023.
//

import SwiftUI

struct CircleButton: View {
    
    let iconName: String
    
    var body: some View {

        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.white)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.black.opacity(0.5))
            )
            .shadow(
                color: Color.black,
                radius: 10,
                x: 0, y: 0
            )
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
            CircleButton(iconName: "heart.fill")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        
    }
}
