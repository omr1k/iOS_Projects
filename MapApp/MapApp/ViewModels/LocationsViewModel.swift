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
//
//    @Published var savedLocations : [LocationModel] = []
//
//    @Published var mapLocation : LocationModel {
//        didSet{
//            updateMapRegion(location: mapLocation)
//        }
//    }
//
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
//
//        self.mapLocation = savedLocations.first!
//        self.updateMapRegion(location: LocationModel.example)
//        loadSavedLocations()
//    }
//
//    private func updateMapRegion(location : LocationModel){
//        let coordinates = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
//        withAnimation(.easeInOut){
//            mapRegion = MKCoordinateRegion(center: coordinates, span: mapSpan)
//        }
//    }
//
//    func showNextLocation(newLocation: LocationModel){
//        withAnimation(.easeInOut){
//            mapLocation = newLocation
//            showLocationsList = false
//        }
//    }
//
//    func toggleLocationsList(){
//        withAnimation(.spring(response: 0.5)){
//            showLocationsList.toggle()
//        }
//    }
//
//    func nextButtonPressed(){
//
//        print("nnnnnnl,l,hlklkgkljglkgk,jg")
////        // First,  Get Current location
////        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else { return }
////
////        // Check in current index if valid
////        let nextIndex = currentIndex + 1
////        guard locations.indices.contains(nextIndex) else {
////            // next index in not valid
////            // Returen 0
////            guard let firstLocation = locations.first else {return}
////            showNextLocation(newLocation: firstLocation)
////            return
////        }
////
////        // Next location in valid
////        let nextLocation = locations[nextIndex]
////        showNextLocation(newLocation: nextLocation)
//    }
//
//}
//
//extension LocationsViewModel {
//    // Load All saved Locations from documents json file
//     func loadSavedLocations() {
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






//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Omar Khattab on 12/02/2023.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {

    @Published var locations : [Location]
    @Published var savedLocations : [LocationModel] = []
    @Published var mapLocation : Location {
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    @Published var showLocationsList: Bool = false
    @Published var showDetailsSheet : Location? = nil
    @Published var showAddLocationSheet: Bool = false
    let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedLocations")

    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
        loadSavedLocations()
    }

    private func updateMapRegion(location : Location){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }

    func toggleLocationsList(){
        withAnimation(.spring(response: 0.5)){
            showLocationsList.toggle()
        }
    }

    func showNextLocation(newLocation: Location){
        withAnimation(.easeInOut){
            mapLocation = newLocation
            showLocationsList = false
        }
    }

    func nextButtonPressed(){
        // First,  Get Current location
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else { return }

        // Check in current index if valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next index in not valid
            // Returen 0
            guard let firstLocation = locations.first else {return}
            showNextLocation(newLocation: firstLocation)
            return
        }

        // Next location in valid
        let nextLocation = locations[nextIndex]
        showNextLocation(newLocation: nextLocation)
    }

}

extension LocationsViewModel {
    // Load All saved Locations from documents json file
    func loadSavedLocations() {
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            savedLocations = try decoder.decode([LocationModel].self, from: data).reversed()
        } catch {
            debugPrint(error.localizedDescription)
            savedLocations = []
        }
    }
}
