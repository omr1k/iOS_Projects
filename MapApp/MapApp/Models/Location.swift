//
//  Location.swift
//  MapApp
//
//  Created by Omar Khattab on 11/02/2023.
//

import Foundation
import MapKit


struct LocationModel: Codable, Identifiable, Equatable {
    
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        lhs.id == rhs.id
    }
    var id = UUID()
    let name : String
    let description : String?
    let lat: Double
    let long: Double
    let dateAdded: String
    
    static let example = LocationModel(name: "", description: "", lat: 51.5, long: -0.12, dateAdded: "lsldh")
}







//struct Location : Identifiable , Equatable{
//    
//    static func == (lhs: Location, rhs: Location) -> Bool {
//        lhs.id == rhs.id
//    }
//    
//    var id: String {
//        name + cityName
//    }
//    let name : String
//    let cityName : String
//    let coordinates : CLLocationCoordinate2D
//    let description : String
//    let imageNames : [String]
//    let link : String
//}
