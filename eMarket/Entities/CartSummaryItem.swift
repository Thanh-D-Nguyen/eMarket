//
//  CartSummaryItem.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import Foundation

struct CartSummaryItem {
    var totalPrice: Int
    var totalItems: Int
    
    var checkoutText: String {
        let checkout = NSLocalizedString("checkout", comment: "")
        return String(format: checkout, totalItems)
    }
    var totalPriceText: String {
        let yenSign = NSLocalizedString("yenSign", comment: "")
        return "\(totalPrice)" + yenSign
    }
}
