//
//  User.swift
//  Day60Challenge
//
//  Created by Richard-Bollans, Jack on 30/01/2022.
//

import Foundation

struct Response: Codable {
    var users: [User]
}

struct User: Codable {
    let id: String
    let isActive: Bool
    let name : String
    let age: Int8
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
