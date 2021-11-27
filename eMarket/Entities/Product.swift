//
//  Product.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

struct Product: Codable {
    let name: String
    let price: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case name, price
        case imageURL = "imageUrl"
    }
    
    init() {
        name = ""
        price = 0
        imageURL = ""
    }

    init(name: String, price: Int, imageURL: String) {
        self.name = name
        self.price = price
        self.imageURL = imageURL
    }
}

extension Product {
    var priceText: String {
        let yenSign = NSLocalizedString("yenSign", comment: "")
        return "\(price)" + yenSign
    }
}
