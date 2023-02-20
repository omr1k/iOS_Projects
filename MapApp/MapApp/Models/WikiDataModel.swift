//
//  WikiDataModel.swift
//  MapApp
//
//  Created by Omar Khattab on 17/02/2023.
//

import Foundation

// MARK: - Raw Server Response
struct Result: Codable {
    let query: Query
}

// MARK: - Query
struct Query: Codable {
    let pages: [Int: Page]
}

// MARK: - Page
struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    let coordinates: [Coordinate]
    let thumbnail: Thumbnail?
}

// MARK: - Coordinate
struct Coordinate: Codable {
    let lat, lon: Double
    let primary: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
    let width, height: Int
}






// MARK: - Final Used Data
//struct ServerResponse: Decodable {
//
//    var id: Int
//    var locationTitle: String
//    var description: String?
//    var Lat: Double
//    var long: Double
//    var locationPic: String
//
//    init(from decoder: Decoder) throws {
//        let response = try Result(from: decoder)
//
//        // Now you can pick items that are important to your data model,
//        // conveniently decoded into a Swift structure
//
//        id = pages.first.id
//
//
//    }
//}

