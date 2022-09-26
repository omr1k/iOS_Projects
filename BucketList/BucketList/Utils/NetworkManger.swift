//
//  NetworkManger.swift
//  BucketList
//
//  Created by Omar Khattab on 25/09/2022.
//

import Foundation

struct NetworkManager {
    
    func fetchNearbyPlaces(location:Location) async -> [Page]? {
        
        let WikiNearByUrlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        let url = URL(string: WikiNearByUrlString)!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            var pages = [Page]()
            pages = items.query.pages.values.sorted() // store sorted array of pages in a var
            return pages // returen final response
        }catch{
           print(error)
        }
        return nil
    }
}


















//import Foundation
//
//struct NetworkManager {
//
//    func fetchNearbyPlaces(latitude: String, longitude:String, location:Location) async -> [Page]?{
//
//        let WikiNearByUrlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
//
////        guard
//          let url = URL(string: WikiNearByUrlString)! //else
////        {
////            print("Bad URL: \(WikiNearByUrlString)")
////            return
////        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            // we got some data back!
//            let items = try JSONDecoder().decode(Result.self, from: data)
//            return items
//
//            // success – convert the array values to our pages array
////            pages = items.query.pages.values.sorted { $0.title < $1.title }
////            return pages
////            loadingState = .loaded
//        } catch {
//            // if we're still here it means the request failed somehow
////            loadingState = .failed
//            print(error)
//        }
//    }
//
//}
