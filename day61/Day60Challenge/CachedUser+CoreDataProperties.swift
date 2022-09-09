//
//  CachedUser+CoreDataProperties.swift
//  Day60Challenge
//
//  Created by Richard-Bollans, Jack on 02/02/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    public var wrappedCompany: String {
       company ?? "Unknown company"
    }
    public var wrappedName: String {
       name ?? "Unknown name"
    }
    public var wrappedId: String {
       id ?? "Unknown Id"
    }
    public var wrappedEmail: String {
       email ?? "Unknown email"
    }
    public var wrappedAddress: String {
       address ?? "Unknown address"
    }
    public var wrappedAbout: String {
       about ?? "Unknown about"
    }
    
    public var wrappedTags: String {
       tags ?? ""
    }
   
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var friendsArray: [Friend] {
        let set = friends as? Set<CachedFriend> ?? []
        var newFriends = [Friend]()
        for cachedFriend in set {
            let friend = Friend(id: cachedFriend.wrappedId, name: cachedFriend.wrappedName)
            newFriends.append(friend)
        }
        return newFriends.sorted {
            $0.name < $1.name
        }
    }

}

// MARK: Generated accessors for friend
extension CachedUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
