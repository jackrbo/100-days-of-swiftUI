//
//  Order.swift
//  CupcakCorner
//
//  Created by Richard-Bollans, Jack on 7.10.2022.
//

import Foundation

class OrderClass: ObservableObject {
    @Published var order = Order()
}
struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var cost: Double {
        var cost = Double(quantity) * 2

        cost += (Double(type) / 2)

        if extraFrosting {
            cost += Double(quantity)
        }

        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
}

//struct Order: Codable {
//    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
//
//    @Published var type = 0
//    @Published var quantity = 3
//
//    @Published var specialRequestEnabled = false {
//        didSet {
//            if specialRequestEnabled == false {
//                extraFrosting = false
//                addSprinkles = false
//            }
//        }
//    }
//    @Published var extraFrosting = false
//    @Published var addSprinkles = false
//
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
//
//    enum CodingKeys: CodingKey {
//        case type
//        case quantity
//        case specialRequestEnabled
//        case extraFrosting
//        case addSprinkles
//        case name
//        case streetAddress
//        case city
//        case zip
//    }
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        type = try container.decode(Int.self, forKey: CodingKeys.type)
//        quantity = try container.decode(Int.self, forKey: CodingKeys.quantity)
//        specialRequestEnabled = try container.decode(Bool.self, forKey: CodingKeys.specialRequestEnabled)
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: CodingKeys.addSprinkles)
//        name = try container.decode(String.self, forKey: CodingKeys.name)
//        streetAddress = try container.decode(String.self, forKey: CodingKeys.streetAddress)
//        city = try container.decode(String.self, forKey: CodingKeys.city)
//        zip = try container.decode(String.self, forKey: CodingKeys.zip)
//    }
//    init() { }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(type, forKey: CodingKeys.type)
//        try container.encode(quantity, forKey: CodingKeys.quantity)
//        try container.encode(specialRequestEnabled, forKey: CodingKeys.specialRequestEnabled)
//        try container.encode(extraFrosting, forKey: CodingKeys.extraFrosting)
//        try container.encode(addSprinkles, forKey: CodingKeys.addSprinkles)
//        try container.encode(name, forKey: CodingKeys.name)
//        try container.encode(streetAddress, forKey: CodingKeys.streetAddress)
//        try container.encode(city, forKey: CodingKeys.city)
//        try container.encode(zip, forKey: CodingKeys.zip)
//    }
//    var hasValidAddress: Bool {
//        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
//        !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
//        !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
//        !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
//    }
//
//    var cost: Double {
//        var cost = Double(quantity) * 2
//
//        cost += (Double(type) / 2)
//
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//        return cost
//    }
//
//}
