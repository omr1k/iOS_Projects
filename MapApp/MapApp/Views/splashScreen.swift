//
//  splashScreen.swift
//  MapApp
//
//  Created by Omar Khattab on 21/02/2023.
//

import SwiftUI
import MapKit

struct splashScreen: View {
    
    @State private var isSplash = true
    @State private var rotateLogo = false
    
    var body: some View {
        
        Group {
            if isSplash {
                splashBody
            } else {
                LocationsView()
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                withAnimation(.easeIn){
                    self.rotateLogo = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                withAnimation(.easeIn){
                    self.isSplash = false
                }
            }
            
        }
    }
}

struct splashScreen_Previews: PreviewProvider {
    static var previews: some View {
        splashScreen()
    }
}

extension splashScreen {
    private var splashBody: some View {
        ZStack {
            Group{
                blurredMap
                LiveBackgroundView().opacity(0.3)
            }.ignoresSafeArea()
            VStack{
                Spacer()
                VStack(spacing: 7){
                    Image("appLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75,height: 75, alignment: .top)
                        .cornerRadius(10)
                        .scaleEffect(2)
                        .padding(.top, 50)
                        .rotation3DEffect(rotateLogo ? Angle(degrees: 720) : Angle(degrees: 0.0), axis: (x:0 , y: 1, z: 0))
                        .padding()
                    Text("Hola Pins")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .rotation3DEffect(rotateLogo ? Angle(degrees: -360) : Angle(degrees: 0.0), axis: (x:0 , y: 1, z: 0))
                        .padding()
                }
                Spacer()
                ProgressView()
                    .tint(.white)
                    .scaleEffect(2)
                Spacer()
            }
            
        }
        
    }
    
    
    private var blurredMap: some View {
        
        ZStack{
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.16), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))), interactionModes: [])
                .blur(radius: 2)
        }
    }
    
}
