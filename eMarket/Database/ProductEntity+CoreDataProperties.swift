//
//  ProductEntity+CoreDataProperties.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//
//

import Foundation
import CoreData
import UIKit


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image_url: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Int32
    @NSManaged public var quantity: Int32

}

extension ProductEntity {
    var totalPrice: Int {
        return Int(price * quantity)
    }
    var totalPriceText: String {
        let yenSign = NSLocalizedString("yenSign", comment: "")
        return  "\(totalPrice)" + yenSign
    }
    
    func convertProductForAPI() -> Product {
        return Product(name: self.name ?? "", price: Int(self.price), imageURL: self.image_url ?? "")
    }
}
