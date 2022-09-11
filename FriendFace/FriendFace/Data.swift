////
////  Data.swift
////  FriendFace
////
////  Created by Omar Khattab on 11/09/2022.
////
//
//import Foundation
//
//struct UserX: Codable, Identifiable {
//    let id: UUID
//    let isActive: Bool
//    let name: String
//    let age: Int
//    let company: String
//    let email: String
//    let address: String
//    let about: String
//    let registered: Date
//    let tags: [String]
//    let friends: [Friend]
//    
//    var formattedDate: String {
//        registered.formatted(date: .abbreviated, time: .omitted)
//    }
//}
//
//struct Friend: Codable, Identifiable {
//    let id: UUID
//    let name: String
//}
