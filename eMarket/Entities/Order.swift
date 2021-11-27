//
//  Order.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

struct Order: Codable {
    let products: [Product]
    let deliveryAddress: String

    enum CodingKeys: String, CodingKey {
        case products
        case deliveryAddress = "delivery_address"
    }
}

extension Order {
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
