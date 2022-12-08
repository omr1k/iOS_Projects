//
//  LocationModel.swift
//  WeatherByOmar
//
//  Created by Omar Khattab on 27/11/2022.
//

import Foundation
import MapKit

struct LocationModel: Identifiable {
    let id  = UUID()
    let name : String
    let coordinate: CLLocationCoordinate2D
}
