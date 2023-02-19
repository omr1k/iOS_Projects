//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Omar Khattab on 12/02/2023.
//

import Foundation
import MapKit
import SwiftUI

@MainActor
class LocationsViewModel: ObservableObject {

    @Published var savedLocations : [LocationModel] = []
    @Published var wikiPages = [Page]()
    @Published var locationWeatherData = WeatherModel()
    enum loadingStates {
        case loading, loaded, failed
    }
    @Published var loadingState = loadingStates.loading
    @Published var mapLocation : LocationModel {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    @Published var showLocationsList: Bool = false
    @Published var showDetailsSheet : LocationModel? = nil
    @Published var showAddLocationSheet: Bool = false
    let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedLocations")

    init(){
        mapLocation = LocationModel.example
        loadSavedLocations()
    }

    private func updateMapRegion(location : LocationModel){
        let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(center: coordinates, span: mapSpan)
        }
    }
    
    func showNextLocation(newLocation: LocationModel){
        withAnimation(.easeInOut){
            mapLocation = newLocation
            showLocationsList = false
        }
    }
    
    func toggleLocationsList(){
        withAnimation(.spring(response: 0.5)){
            showLocationsList.toggle()
        }
    }

    func nextButtonPressed(){

        // First,  Get Current location
        guard let currentIndex = savedLocations.firstIndex(where: {$0 == mapLocation}) else { return }
        // Check in current index if valid
        let nextIndex = currentIndex + 1
        guard savedLocations.indices.contains(nextIndex) else {
            // next index in not valid
            // Returen 0
            guard let firstLocation = savedLocations.first else {return}
            showNextLocation(newLocation: firstLocation)
            
            return
        }
        // Next location in valid
        let nextLocation = savedLocations[nextIndex]
        showNextLocation(newLocation: nextLocation)
    }
}

extension LocationsViewModel {
    // Data
     func loadSavedLocations() {
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            savedLocations = try decoder.decode([LocationModel].self, from: data).reversed()
            mapLocation = savedLocations.first!
            
        } catch {
            debugPrint(error.localizedDescription)
            savedLocations = []
        }
    }
    
    func deleteAllSavedLocations(){
        savedLocations = []
        mapLocation = LocationModel.example
        do {
            let data = try JSONEncoder().encode(savedLocations)
            try data.write(to: jsonFilePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
        showLocationsList = false
    }
}


extension LocationsViewModel {
    
    // Networking Functions
    func getWikiData(lat: Double, long: Double) async {
        let WikiNearByUrlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(lat)%7C\(long)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: WikiNearByUrlString) else {
            print("bad url")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            wikiPages = items.query.pages.values.sorted {$0.title < $1.title }
            loadingState = .loaded
        } catch{
          print("error")
            loadingState = .failed
        }
    }
    
    func getWeather(lat: Double, long: Double) async {
        
        let endpoint = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=10108aff3679f8ce2c724b63b5e29203&lang=en&units=metric"
        print("======>\(endpoint)")
        
        let url = URL(string: "\(endpoint)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringCacheData
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode(WeatherModel.self, from: data)
            print("\(locationWeatherData)")
            locationWeatherData = decodedData
        } catch {
            print(error)
        }
    }
    
    
}






































//
////
////  LocationsViewModel.swift
////  MapApp
////
////  Created by Omar Khattab on 12/02/2023.
////
//
//import Foundation
//import MapKit
//import SwiftUI
//
//class LocationsViewModel: ObservableObject {
//
//    @Published var locations : [Location]
//    @Published var savedLocations : [LocationModel] = []
//    @Published var mapLocation : Location {
//        didSet{
//            updateMapRegion(location: mapLocation)
//        }
//    }
//    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
//    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    @Published var showLocationsList: Bool = false
//    @Published var showDetailsSheet : Location? = nil
//    @Published var showAddLocationSheet: Bool = false
//    let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedLocations")
//
//    init(){
//        let locations = LocationsDataService.locations
//        self.locations = locations
//        self.mapLocation = locations.first!
//        self.updateMapRegion(location: locations.first!)
//        loadSavedLocations()
//    }
//
//    private func updateMapRegion(location : Location){
//        withAnimation(.easeInOut){
//            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
//        }
//    }
//
//    func toggleLocationsList(){
//        withAnimation(.spring(response: 0.5)){
//            showLocationsList.toggle()
//        }
//    }
//
//    func showNextLocation(newLocation: Location){
//        withAnimation(.easeInOut){
//            mapLocation = newLocation
//            showLocationsList = false
//        }
//    }
//
//    func nextButtonPressed(){
//        // First,  Get Current location
//        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else { return }
//
//        // Check in current index if valid
//        let nextIndex = currentIndex + 1
//        guard locations.indices.contains(nextIndex) else {
//            // next index in not valid
//            // Returen 0
//            guard let firstLocation = locations.first else {return}
//            showNextLocation(newLocation: firstLocation)
//            return
//        }
//
//        // Next location in valid
//        let nextLocation = locations[nextIndex]
//        showNextLocation(newLocation: nextLocation)
//    }
//
//}
//
//extension LocationsViewModel {
//    // Load All saved Locations from documents json file
//    func loadSavedLocations() {
//        do {
//            let data = try Data(contentsOf: jsonFilePath)
//            let decoder = JSONDecoder()
//            savedLocations = try decoder.decode([LocationModel].self, from: data).reversed()
//        } catch {
//            debugPrint(error.localizedDescription)
//            savedLocations = []
//        }
//    }
//}
