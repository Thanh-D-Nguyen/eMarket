//
//  AppService.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation

class AppService {
    class func bootstrap() {
        // Prepare app services
        // ex: Realm, Firebase, Migration data...
        // Prepare tmp address
        if StoreDataManagement.shared.getAllAddress()?.count == 0 {
           _ = StoreDataManagement.shared.insertAddress(deliveryAddress: "Tokyo Japan")
        }
    }
}
