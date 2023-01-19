//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Omar Khattab on 29/09/2022.
//

import MapKit
import LocalAuthentication
import Foundation

extension EditView{
    
    @MainActor class EditViewViewModel: ObservableObject {
        
        enum loadingState {
            case loading, loaded, failed
        }
  
        
        @Published var name: String
        @Published var  description: String
        
        @Published var loadingState = loadingState.loading
        @Published var pages = [Page]()
        
        var location: Location?
        
        init(location: Location){
            name = location.name
            description = location.description
            self.location = location
        }
    } // Main actor end
    
} // extention end

















//        init(location: Location) {
//            self.location = location
//
//            _name = Published(initialValue: location.name)
//            _description = Published(initialValue: location.description)
//        }



//func GetDataFromWiki() async -> [Page]? {
//    var pages = [Page]()
//    if let responseData = await NetworkManager().fetchNearbyPlaces(location: location){
//        pages = responseData
//        return pages
//    }
//    return nil
//}
