//
//  Friend.swift
//  FriendFace
//
//  Created by Omar Khattab on 14/09/2022.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
