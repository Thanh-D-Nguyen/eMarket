//
//  Store.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

struct Store: Codable {
    let name: String
    let rating: Double
    let openingTime, closingTime: String?
}

extension Store {
    var formatedOpenTime: String {
        let openTime = openingTime ?? "N/A"
        return "Open: " + openTime.formatTime()
    }
    var formatedClosingTime: String {
        let closeTime = closingTime ?? "N/A"
        return "Close: " + closeTime.formatTime()
    }
}
