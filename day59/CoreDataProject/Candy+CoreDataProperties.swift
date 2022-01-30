//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Richard-Bollans, Jack on 29/01/2022.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown name"
    }
}

extension Candy : Identifiable {

}
