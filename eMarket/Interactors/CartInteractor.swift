//
//  CartInteractor.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import Foundation

protocol CartInteractorProtocol: AnyObject {
    var didNoticeAddExistedProduct: (() -> Void)? { get set }
    func addToCart(product: Product, id: Int) -> Bool
    func getProductsInCart() -> [ProductEntity]
    func deleteCartProduct(_ product: ProductEntity) -> Bool
    func updateProductQuantity(_ product: ProductEntity, action: StepAction)
    func getDeliveryAddress() -> String
    
    func deleteAllCartProducts() -> Bool
    
    func updateDeliveryAddress(_ address: String)
}

class CartInteractor {
    var didNoticeAddExistedProduct: (() -> Void)?
}

extension CartInteractor: CartInteractorProtocol {
    func addToCart(product: Product, id: Int) -> Bool {
        let products = StoreDataManagement.shared.getAllProducts()
        if products?.first(where: { $0.id == id }) != nil {
            print("Product already added")
            didNoticeAddExistedProduct?()
            return false
        }
        let product = StoreDataManagement.shared.insertProduct(product, id: id, quantity: 1)
        return product != nil
    }
    
    func getProductsInCart() -> [ProductEntity] {
        return StoreDataManagement.shared.getAllProducts() ?? []
    }
    
    func deleteCartProduct(_ product: ProductEntity) -> Bool {
        return StoreDataManagement.shared.removeProduct(product)
    }
    
    func updateProductQuantity(_ product: ProductEntity, action: StepAction) {
        var newQty = product.quantity
        if action == .sub {
            newQty -= 1
        } else if action == .plus {
            newQty += 1
        }
        if newQty > 0 {
            StoreDataManagement.shared.updateProduct(product, quantity: newQty)
        } else {
            _ = deleteCartProduct(product)
        }
    }
    
    func getDeliveryAddress() -> String {
        return StoreDataManagement.shared.getAllAddress()?.first?.delivery_address ?? ""
    }
    
    func deleteAllCartProducts() -> Bool {
        return StoreDataManagement.shared.removeAllProducts()
    }
    
    func updateDeliveryAddress(_ address: String) {
        StoreDataManagement.shared.updateDeliveryAddress(address)
    }
}
