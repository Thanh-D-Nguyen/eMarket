//
//  AddressEntity+CoreDataProperties.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//
//

import Foundation
import CoreData


extension AddressEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressEntity> {
        return NSFetchRequest<AddressEntity>(entityName: "AddressEntity")
    }

    @NSManaged public var delivery_address: String?
    @NSManaged public var id: String

}
