//
//  Order.swift
//  CupcakeCorner
//
//  Created by Richard-Bollans, Jack on 28.9.2021.
//

import Foundation

extension String {
    /// A Boolean value indicating whether a string has no chracters except white spaces
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

class OrderModel: ObservableObject, Codable {
    @Published var order = Order()
    
    enum codingKeys: CodingKey {
        case order
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        try container.encode(order, forKey: .order)
    }
    
    init() { }
}

struct Order: Codable {
    static var types = ["Vanilla", "Strawberry", "Chocloate", "Rainbow"]
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
    
    // Contact details
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isBlank || streetAddress.isBlank || city.isBlank || zip.isBlank {
            return false
        }
        return true
    }
    
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
   
    
}
