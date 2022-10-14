//
//  Person+CoreDataProperties.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 14/10/2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imageFilename: String?
    @NSManaged public var name: String?
    @NSManaged public var imageAbslutePath: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

    var wrappedimageFilename: String {imageFilename ?? "Unknown"}
    var wrappedName: String {name ?? "Unknown"}
    var wrappedlatitude: Double {latitude}
    var wrappedlongitude: Double {longitude}
    
    
}

extension Person : Identifiable {

}
