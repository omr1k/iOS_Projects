// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct WeatherModel: Codable, Identifiable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone, id: Int?
    var name: String?
    var cod: Int?
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - Coord
struct Coord: Codable {
    var lon, lat: Double?
}

// MARK: - Main
struct Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity, seaLevel, grndLevel: Int?

    
}

// MARK: - Sys
struct Sys: Codable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var main, weatherDescription, icon: String?

}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
}











////
////  Model.swift
////  WeatherByOmar
////
////  Created by Omar Khattab on 22/11/2022.
////
//
//import Foundation
//
//// MARK: - WeatherModel
//struct WeatherModel: Codable {
//    let coord: Coord
//    let weather: [Weather]
//    let base: String
//    let main: Main
//    let visibility: Int
//    let wind: Wind
//    let clouds: Clouds
//    let dt: Int
//    let sys: Sys
//    let timezone : Int
//    let id: Int
//    let name: String
//    let cod: Int
//}
//
//// MARK: - Coord
//struct Coord: Codable {
//    let lon : Double
//    let lat: Double
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int
//    let main :String
//    let weatherDescription : String
//    let icon: String
//}
//
//// MARK: - Main
//struct Main: Codable {
//    let temp, feelsLike, tempMin, tempMax: Double
//    let pressure, humidity, seaLevel, grndLevel: Int
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//    let speed: Double
//    let deg: Int
//    let gust: Double
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//    let all: Int
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//    let type, id: Int
//    let country: String
//    let sunrise, sunset: Int
//}
//
//
//
//
