//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Omar Khattab on 26/09/2022.
//

import MapKit
import LocalAuthentication
import Foundation

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
     
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published private(set) var locations : [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var noBiometricsError = false

     
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        Task { @MainActor in
                                self.isUnlocked = true
                            }
                    } else {
                        Task { @MainActor in
                                self.noBiometricsError = true
                            }
                    }
                }
            } else {
                Task { @MainActor in
                        self.noBiometricsError = true
                    }
            }
        } // authenticate method end
        
    }
}
