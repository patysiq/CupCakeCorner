//
//  Order.swift
//  CupcakeCorner
//
//  Created by PATRICIA S SIQUEIRA on 20/02/21.
//

import Foundation

class ClassyOrder : ObservableObject {
    @Published var order : Order
    
    init() {
        order = Order(type: 0, quantity: 3, extraFrosting: false, extraSprinkles: false, name: "", streetAddress: "", city: "", zip: "", specialRequestEnabled: false)
    }
}

struct Order : Codable {
    enum CodingKeys : CodingKey {
        case type, quantity, extraFrosting, extraSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var extraFrosting = false
    var extraSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var specialRequestEnabled = false {
        didSet {
            if false == specialRequestEnabled {
                extraSprinkles = false
                extraFrosting = false
            }
        }
    }
    
    var cost : Double {
        var cost = Double(quantity * 2)
        
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if extraSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
        var hasValidAddress: Bool {
            if name.isEmptyOrWhitespace || streetAddress.isEmptyOrWhitespace || city.isEmptyOrWhitespace || zip.isEmptyOrWhitespace {
                return false
            }
    
            return true
        }
    
}

//class Order: ObservableObject, Codable {
//    enum CodingKeys: CodingKey {
//        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//    }
//
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
//    var hasValidAddress: Bool {
//        if name.isEmptyOrWhitespace || streetAddress.isEmptyOrWhitespace || city.isEmptyOrWhitespace || zip.isEmptyOrWhitespace {
//            return false
//        }
//
//        return true
//    }
//
//    var cost: Double {
//        // $2 per cake
//        var cost = Double(quantity) * 2
//
//        // complicated cakes cost more
//        cost += (Double(type) / 2)
//
//        // $1/cake for extra frosting
//        if extraFrosting {
//            cost += Double(quantity)
//        }
//
//        // $0.50/cake for sprinkles
//        if addSprinkles {
//            cost += Double(quantity) / 2
//        }
//
//        return cost
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//
//    init() { }
//}


extension String {
    var isEmptyOrWhitespace : Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
