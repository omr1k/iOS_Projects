//
//  ContentView.swift
//  BucketList
//
//  Created by Omar Khattab on 21/09/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        
        if viewModel.isUnlocked {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate){
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                    }.onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
            .ignoresSafeArea()
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        viewModel.addLocation()
                    } label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }// vstack end
        } // zstack end
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) {
                viewModel.update(location: $0)
            }
        }
        .alert("No Biometrecs", isPresented: $viewModel.noBiometricsError) {
                   Button("Use Passcode", role: .cancel) { }
               }
            
    } else {
            Button("Unlock Places") {
                viewModel.authenticate()
                
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
