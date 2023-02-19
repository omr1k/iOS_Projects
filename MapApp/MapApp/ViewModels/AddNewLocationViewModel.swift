//
//  AddNewLocationViewModel.swift
//  MapApp
//
//  Created by Omar Khattab on 15/02/2023.
//

import Foundation
import MapKit
import CoreLocation

@MainActor
class AddNewLocationViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var mapRegion = MKCoordinateRegion()
    @Published var savedLocations : [LocationModel] = []
    @Published var nameText = ""
    @Published var discText = ""

    let jsonFilePath = FileManager.documentsDirectory.appendingPathComponent("SavedLocations")

    var manager = CLLocationManager()
    override init(){
        super.init()
        manager.delegate = self
        loadSavedLocations()
        
    }
    
    func startDetectingLocation(){
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stopDetectingLocation(){
        manager.stopUpdatingLocation()
    }
    
    func CurrentDate() -> String {
        let time = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = timeFormatter.string(from: time)
        return stringDate
    }
}

extension AddNewLocationViewModel {
    
   //MARK: Location Related
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        if lastKnownLocation?.longitude != nil {
            Task{
                mapRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: lastKnownLocation?.latitude ?? 51, longitude: lastKnownLocation?.longitude ?? -12),
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            }
        }
    }
}

extension AddNewLocationViewModel {
    
    //MARK: Saving Data Related
    private func save() {
        do {
            let data = try JSONEncoder().encode(savedLocations)
            try data.write(to: jsonFilePath, options: [.atomic, .completeFileProtection])
            print("save Path====>\(jsonFilePath.path)")
            print(savedLocations.count)
            nameText = ""
            discText = ""
        } catch {
            print("Unable to save data.")
        }
    }
    
    func addLocation() {
        savedLocations.append(LocationModel(name: nameText, description: discText ?? "", lat: mapRegion.center.latitude,
                                            long: mapRegion.center.longitude, dateAdded: CurrentDate()))
        save()
    }
    
    func loadSavedLocations() {
        do {
            let data = try Data(contentsOf: jsonFilePath)
            let decoder = JSONDecoder()
            savedLocations = try decoder.decode([LocationModel].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            savedLocations = []
        }
    }
}




