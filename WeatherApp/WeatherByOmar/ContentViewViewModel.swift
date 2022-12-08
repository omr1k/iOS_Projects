//
//  ContentViewModel.swift
//  WeatherByOmar
//
//  Created by Omar Khattab on 22/11/2022.
//



import Foundation
import CoreLocation
import MapKit

extension ContentView {
    
    @MainActor class ContentViewViewModel: NSObject, CLLocationManagerDelegate, ObservableObject{
        
        @Published var isLoading = true
        @Published var showError = false
        
        
        // MARK: - Detecting User Location
        @Published var lastKnownLocation: CLLocationCoordinate2D?
        @Published var formattedCurrentDate = Date().formatted(date: .complete, time: .shortened) // Thursday, May 26, 2022, 8:15:28 PM

        var manager = CLLocationManager()
        
        override init(){
            super.init()
            manager.delegate = self
            
        }
        
        func startDetectingLocation(){
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        
        func stopDetectingLocation(){
            manager.stopUpdatingLocation()
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            lastKnownLocation = locations.first?.coordinate
            
            if lastKnownLocation?.longitude != nil {
                Task{
                    await getData()
                }
            }
            
            print(lastKnownLocation as Any)

        }
        
        // MARK: - Fetch Weather Data Accourding to lat and long and set map view requirements
        @Published var weatherData = WeatherModel()
        @Published var mapRegion = MKCoordinateRegion()
        @Published var locations = [LocationModel]()
        
        func getData() async {
            showError = false
            
            stopDetectingLocation()
            
            let lat = "\(lastKnownLocation?.latitude ?? 0.0)"
            let long = "\(lastKnownLocation?.longitude ?? 0.0)"
            
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
                weatherData = decodedData
                print(decodedData)
                isLoading = false
                print(decodedData)
                
            } catch {
                print(error)
                showError = true
            }
            
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lastKnownLocation?.latitude ?? 00, longitude: lastKnownLocation?.longitude ?? 00), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            
            let coords = CLLocationCoordinate2D(latitude: lastKnownLocation?.latitude ?? 0.0, longitude: lastKnownLocation?.longitude ?? 0.0)
            locations.append(LocationModel(name: weatherData.name ?? "", coordinate: coords))
        }
        
        func weatherIconUrl() -> String{
            let respnseWeatherIcon = weatherData.weather?[0].icon
            let iconUrl = "https://openweathermap.org/img/wn/\(respnseWeatherIcon!)@2x.png"
            return iconUrl
        }
        
        
        
    }
}






// MARK: - Make map with pin
       
//        @Published var mapRegion2 = MKCoordinateRegion()
//        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
//        @Published var locations = [
//            LocationModel(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 33.359676, longitude: 43.787042))
//        ]


















//
//import Foundation
//
//class ContentViewViewModel: ObservableObject{
//
//    var location = LocationManger()
//
//    @Published var coordinates: (latitude: Double, longitude: Double) = (0.0, 0.0)
//
//    init(){
//        location.start()
//        print(coordinates)
//    }
//
//    func getUserCoordinates(){
//
//        coordinates.latitude = location.lastKnownLocation?.latitude ?? 0.0
//        coordinates.longitude = location.lastKnownLocation?.longitude ?? 0.0
//
//        print(coordinates)
//    }
//}




//
//@Published var latitude = Double()
//@Published var longitude = Double()
