//
//  CashedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Omar Khattab on 12/09/2022.
//
//

import Foundation
import CoreData


extension CashedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CashedFriend> {
        return NSFetchRequest<CashedFriend>(entityName: "CashedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CashedUser?

    var wrappedName: String {
            name ?? "Unknown"
        }
    
}

extension CashedFriend : Identifiable {

}
