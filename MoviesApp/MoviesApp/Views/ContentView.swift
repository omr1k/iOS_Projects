//
//  ContentView.swift
//  MoviesApp
//
//  Created by Omar Khattab on 11/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animate = false
    
    var body: some View {
        ZStack{
            
            Circle().foregroundColor(.green).padding()
                .blur(radius: animate ? 20 : 100)
                .offset(x: animate ? 50 : -130 , y: animate ? -30 : -100)
                .task {
                    withAnimation(.easeInOut(duration: 7).repeatForever()){
                        animate.toggle()
                    }
                }
            
            Circle().foregroundColor(.pink).padding()
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? 100 : 130 , y: animate ? 150 : 100)
            
            
            
            VStack(spacing: 30.0){
                Text("Mobile Ticket")
                    .font(.title3).bold()
                    .foregroundColor(.white)
                
                Text(".fs;dma;dlsfjm;aldsf;alsf;lnasd;lfsdl;f;ldsnmf;lmn;l")
            }
            .padding(.horizontal,20)
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        }
        .modifier(CustomBackGroundColor())
    }
}






struct CustomBackGroundColor: ViewModifier {
    
    static let color0 = Color(red: 31/255, green: 17/255, blue: 206/255);
    static let color1 = Color(red: 229/255, green: 43/255, blue: 43/255);
    let gradient = Gradient(colors: [color0, color1]);
    
  func body(content: Content) -> some View {
    content
      .background(
                LinearGradient(
                  gradient: gradient,
                  startPoint: .init(x: 0.00, y: 0.50),
                  endPoint: .init(x: 1.00, y: 0.50)
                )
      )
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
