//
//  LiveBackgroundView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 03/02/2023.
//

import SwiftUI

struct LiveBackgroundView: View {
    
    @State private var animate = false
    static let color0 = Color(red: 76/255, green: 136/255, blue: 175/255);
    static let color1 = Color(red: 156/255, green: 39/255, blue: 176/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(LinearGradient(
                          gradient: gradient,
                          startPoint: .init(x: 0.00, y: 0.50),
                          endPoint: .init(x: 1.00, y: 0.50)
                        ))
                .ignoresSafeArea(.all)
            
            Rectangle().foregroundColor(.green).opacity(0.2).padding()
                .blur(radius: animate ? 90 : 100)
                .offset(x: 0, y: animate ? -500 : 500)
                .rotationEffect(.degrees(161))
                .task {
                    withAnimation(.easeInOut(duration: 1).repeatForever()){
                        animate.toggle()
                    }
                }
            
            Rectangle().foregroundColor(.yellow).opacity(0.5).padding()
                .blur(radius: animate ? 90 : 100)
                .offset(x: animate ? 250 : -250 , y:0)
            
        }
    }
}

struct LiveBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LiveBackgroundView()
    }
}
