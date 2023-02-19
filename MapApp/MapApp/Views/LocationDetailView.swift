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
    let location: LocationModel
    let wikiUrl = URL(string: "https://www.wikipedia.org/")
    var body: some View {
        ScrollView{
            ZStack {
//                LiveBackgroundView()
                VStack{
                    mapOfLocation
                        .shadow(radius: 20)
                    VStack(alignment: .leading, spacing: 16.0){
                        titleSection
                        weatherSection
                        Divider()
                        if location.description != "" {
                            descriptionSection
                            Divider()
                        }
                        switch vm.loadingState {
                        case .loading :
                            HStack(spacing: 8.0) {
                                Text("Loading")
                                ProgressView()
                            }
                        case .loaded :
                            wikiInfoSection
                        case.failed :
                            Text("No Available Near By Locations")
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
        .overlay(closeButton, alignment: .topTrailing)
        .onAppear{
            Task{
                await vm.getWikiData(lat: location.lat, long: location.long)
                await vm.getWeather(lat: location.lat, long: location.long)
            }
        }
        
    }
}

//struct LocationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocationDetailView(location: LocationsDataService.locations.first!)
//    }
//}

extension LocationDetailView {

    private var titleSection: some View {
        
        HStack(){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Spacer()
            let url = "https://www.google.com/maps/@\(location.lat),\(location.long),16z"
            ShareLink(item: URL(string: url)!)
        }
        .padding(.horizontal,5)
    }
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16.0){
            Text(location.description ?? "")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var mapOfLocation: some View {
        Map(
            coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01))),
            
            annotationItems: [location],
            annotationContent: { location in
                MapMarker(coordinate: CLLocationCoordinate2DMake(location.lat, location.long))
        })
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(10)
    }
    
    private var closeButton: some View {
        Button {
            vm.showDetailsSheet = nil
        } label: {
            CircleButton(iconName: "xmark")
        }
    }
    
    private var wikiInfoSection: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Nearby Places")
                Spacer()
                Link("Powered By Wikipedia", destination: wikiUrl!)
                    .foregroundColor(.blue)
                    .font(.footnote)
            }
            
            ForEach(vm.wikiPages, id: \.pageid) { page in
                wikiDataRowView(page: page)
            }
        }
    }
    
    private var weatherSection: some View {
        
        Group(){
            if vm.locationWeatherData.name == nil {
                HStack(spacing: 10){
                    Text("Loading Location Weather")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    ProgressView()
                        .tint(Color.accentColor)
                }
            }
            else {
                Text("Temperature now in \(vm.locationWeatherData.name ?? "") is \(String(vm.locationWeatherData.main?.temp ?? 0.0)) °C")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
        }
        .padding(.horizontal,5)
    }
}
