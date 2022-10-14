//
//  personData.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 08/10/2022.
//

import MapKit
import Foundation

struct personData : Codable, Equatable,Identifiable {
    var id = UUID()
    var name : String
    var imageFilename : String
    var imageAbslutePath : String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
        static func ==(lhs: personData, rhs: personData) -> Bool {
            lhs.id == rhs.id
        }
    
}

