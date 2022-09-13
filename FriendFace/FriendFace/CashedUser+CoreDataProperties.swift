//
//  CashedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Omar Khattab on 12/09/2022.
//
//

import Foundation
import CoreData


extension CashedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CashedUser> {
        return NSFetchRequest<CashedUser>(entityName: "CashedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var formattedDate: String?
    @NSManaged public var friends: NSSet?

    
    
    
    var wrappedName: String {
            name ?? "Unknown"
        }
        
        var wrappedCompany: String {
            company ?? "No job"
        }
        
        var wrappedAbout: String {
            about ?? "No data"
        }
        
        var wrappedAddress: String {
            address ?? "Homeless"
        }
        
        var wrappedEmail: String {
            email ?? "no email"
        }
        
        var wrappedFormattedDate: String {
            formattedDate ?? "N/A"
        }
        
        var wrappedID: UUID {
            id ?? UUID()
        }
        
        public var friendsArray: [CashedFriend] {
            let set = friends as? Set<CashedFriend> ?? []
            return set.sorted {
                $0.wrappedName < $1.wrappedName
            }
        }
}

// MARK: Generated accessors for friends
extension CashedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CashedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CashedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CashedUser : Identifiable {

}
