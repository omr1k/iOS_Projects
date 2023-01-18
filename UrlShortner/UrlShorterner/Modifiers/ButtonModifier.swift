//
//  ButtonModifier.swift
//  UrlShorterner
//
//  Created by Omar Khattab on 18/01/2023.
//

import Foundation
import SwiftUI

struct ButtonModifier: ViewModifier {
  
    func body(content: Content) -> some View {
        content
        .padding()
        .background(.black.opacity(0.75))
        .foregroundColor(.white)
        .font(.largeTitle)
        .bold()
        .clipShape(Circle())
        .padding(.trailing)
        .shadow(color: .purple, radius: 10)
        
    }
}
