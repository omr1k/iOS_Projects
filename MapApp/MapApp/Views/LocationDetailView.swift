//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Omar Khattab on 15/02/2023.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @EnvironmentObject var vm : LocationsViewModel
    let location: Location
    var body: some View {
        ScrollView{
            VStack{
                imageSection
//                mapOfLocation
                    .shadow(radius: 20)
                VStack(alignment: .leading, spacing: 16.0){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapOfLocation
                        .padding(.bottom, 5)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
        .overlay(closeButton, alignment: .topTrailing)
        
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
    }
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self){
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8.0){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16.0){
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let url = URL(string: location.link){
                Link("Read More", destination: url)
                    .foregroundColor(.blue)
            }
        }
    }
    
    private var mapOfLocation: some View {
        Map(
            coordinateRegion: .constant(
                MKCoordinateRegion(
                center: location.coordinates,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01))),
            
            annotationItems: [location],
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates){
                Image(systemName: "pin.fill")
                    .scaleEffect(2.5)
                    .padding(.bottom, 40)
                    .foregroundColor(.red)
            }
        })
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(15)
    }
    
    private var closeButton: some View {
        Button {
            vm.showDetailsSheet = nil
        } label: {
            CircleButton(iconName: "xmark")
        }
    }
}
