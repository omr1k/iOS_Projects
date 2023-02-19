//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Omar Khattab on 14/02/2023.
//

import SwiftUI
import MapKit

struct LocationPreviewView: View {
    
    @EnvironmentObject var vm : LocationsViewModel
    let location: LocationModel
    @State var openMapApiKey: String = "5f9ab7b28d624309bafb9b5c7a7221da"
    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            VStack(alignment: .leading, spacing: 16.0){
                image
                title
            }
            VStack(spacing: 8.0){
                learnMoreButton
                nextButton
            }
        }
        .padding(15)
        .background(
        RoundedRectangle(cornerRadius: 15)
            .fill(.ultraThinMaterial)
            .offset(y: 50)
        )
        .cornerRadius(15)
        .onAppear{
                Task {
                    await vm.getWikiData(lat: location.lat, long: location.long)
                    await MainActor.run {
                        vm.locationWeatherData = WeatherModel()
                    }
                }
            
            
//            vm.locationWeatherData = WeatherModel()
        }
    }
}

//
//struct LocationPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.green
//            LocationPreviewView(location: LocationsDataService.locations.first!)
//        }
//        .previewLayout(PreviewLayout.sizeThatFits)
//        .environmentObject(LocationsViewModel())
//    }
//}


extension LocationPreviewView {
    
    private var image: some View {
        ZStack{
            AsyncImage(url: URL(string: "https://maps.geoapify.com/v1/staticmap?style=osm-carto&width=600&height=600&center=lonlat:\(location.long),\(location.lat)&zoom=13&apiKey=\(openMapApiKey)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
            } placeholder: {
                ProgressView()
                    .tint(Color.accentColor)
                    .frame(width: 100, height: 100)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(15)
    }
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 2.0){
            Text(location.name)
                .font(.title2)
                .bold()
//            Text(location.cityName)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        
    }
    
    private var learnMoreButton: some View{
        Button {
            Task { @MainActor in
                vm.showDetailsSheet = location
            }
            
        } label: {
            Text("Learn More")
                .padding(.horizontal, 5)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .frame(width: 125, height: 35)
                .padding(.horizontal, 5)
        }
        .buttonStyle(.bordered)
    }
}
