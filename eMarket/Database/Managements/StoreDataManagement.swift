//
//  StoreDataManagement.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import Foundation
import CoreData

class StoreDataManagement {
    
    static let shared = StoreDataManagement()
    
    
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = StoreDataManagement.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension StoreDataManagement {
    func insertProduct(_ product: Product, id: Int, quantity: Int) -> ProductEntity? {
        let managedContext = StoreDataManagement.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: managedContext)!
        let productEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        productEntity.setValue(id, forKeyPath: "id")
        productEntity.setValue(quantity, forKey: "quantity")
        productEntity.setValue(product.name, forKeyPath: "name")
        productEntity.setValue(product.imageURL, forKeyPath: "image_url")
        productEntity.setValue(product.price, forKeyPath: "price")
        do {
            try managedContext.save()
            return productEntity as? ProductEntity
        } catch let error as NSError {
            print("Error", error.userInfo)
            return nil
        }
    }
    
    func updateProduct(_ product: ProductEntity, quantity: Int32) {
        let context = StoreDataManagement.shared.persistentContainer.viewContext
        do {
            product.setValue(quantity, forKey: "quantity")
            try context.save()
        } catch let error as NSError {
            print("Error", error.userInfo)
        }
    }
    
    func removeProduct(_ product: ProductEntity) -> Bool {
        let managedContext = StoreDataManagement.shared.persistentContainer.viewContext
        managedContext.delete(product)
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Error", error.userInfo)
            return false
        }
    }
    
    func removeAllProducts() -> Bool {
        let managedContext = StoreDataManagement.shared.persistentContainer.viewContext
        let products = getAllProducts()
        if let products = products {
            for product in products {
                managedContext.delete(product)
            }
        }
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Error", error.userInfo)
            return false
        }
    }
    
    func getAllProducts() -> [ProductEntity]? {
        let managedContext = StoreDataManagement.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductEntity")
        do {
            let products = try managedContext.fetch(fetchRequest)
            return products as? [ProductEntity]
        } catch let error as NSError {
            print("Error", error.userInfo)
            return nil
        }
    }
    
}

extension StoreDataManagement {
    func insertAddress(deliveryAddress: String) -> AddressEntity? {
        let managedContext = StoreDataManagement.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "AddressEntity", in: managedContext)!
        let addressEntity = NSManagedObject(entity: entity, insertInto: managedContext)
        addressEntity.setValue(deliveryAddress, forKeyPath: "delivery_address")
        let uuid = UUID().uuidString
        addressEntity.setValue(uuid, forKeyPath: "id")
        do {
            try managedContext.save()
            return addressEntity as? AddressEntity
        } catch let error as NSError {
            print("Error", error.userInfo)
            return nil
        }
    }
    
    func updateDeliveryAddress(_ address: String) {
        if let addressEntity = getAllAddress()?.first {
            let context = StoreDataManagement.shared.persistentContainer.viewContext
            do {
                addressEntity.delivery_address = address
                try context.save()
            } catch let error as NSError {
                print("Error", error.userInfo)
            }
        }
    }
    
    func getAllAddress() -> [AddressEntity]? {
        let managedContext = StoreDataManagement.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AddressEntity")
        do {
            let address = try managedContext.fetch(fetchRequest)
            return address as? [AddressEntity]
        } catch let error as NSError {
            print("Error", error.userInfo)
            return nil
        }
    }
}
