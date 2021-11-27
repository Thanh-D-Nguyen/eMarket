//
//  CartPresenter.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import Foundation

protocol CartPresenterProtocol: AnyObject {
    
    var summaryItem: CartSummaryItem { get }
    var deliveryAddress: String { get }
    
    func viewDidLoad()
    func viewWillAppear()
        
    func numOfRowInSection(_ section: Int) -> Int
    func cartItemAt(_ index: Int) -> ProductEntity
    
    func dismiss()
    
    func deleteCartAtIndex(_ index: Int)
    func updateCartItemQuantityIndex(_ index: Int, changeAction: StepAction)
    func showEditAddress()
    func processCheckout()
    
}
enum CartTableSection: Int {
    case address
    case item
    
    static let numOfSection = 2
}

class CartPresenter {
    
    private let view: CartViewProtocol
    private let router: CartRouterProtocol
    private let interactor: CartInteractorProtocol
    private let storeInteractor: StoreInteractorProtocol
    private var cartItems: [ProductEntity] = []
    var summaryItem: CartSummaryItem = CartSummaryItem(totalPrice: 0, totalItems: 0)
    var deliveryAddress: String = ""
    
    init(router: CartRouterProtocol,
         view: CartViewProtocol,
         interactor: CartInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
        storeInteractor = StoreInteractor()
    }
    
    private func loadCartInfomation() {
        cartItems = interactor.getProductsInCart()
        deliveryAddress = interactor.getDeliveryAddress()
        let totalItem = cartItems.compactMap({ $0.quantity }).reduce(0, +)
        let totalPrice = cartItems.compactMap({ $0.totalPrice }).reduce(0, +)
        summaryItem = CartSummaryItem(totalPrice: totalPrice, totalItems: Int(totalItem))
    }
}

extension CartPresenter: CartPresenterProtocol {
    
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
        loadCartInfomation()
        view.didLoadCartInformation()
    }
    
    func numOfRowInSection(_ section: Int) -> Int {
        if section == CartTableSection.address.rawValue {
            return 1
        }
        return cartItems.count
    }
    func cartItemAt(_ index: Int) -> ProductEntity {
        if cartItems.indices.contains(index) {
            return cartItems[index]
        }
        return ProductEntity()
    }
    
    func dismiss() {
        router.dismiss()
    }
    
    func deleteCartAtIndex(_ index: Int) {
        if cartItems.indices.contains(index) {
            let entity = cartItems[index]
            let success = interactor.deleteCartProduct(entity)
            if success == true {
                viewWillAppear()
            }
        }
    }
    func updateCartItemQuantityIndex(_ index: Int, changeAction: StepAction) {
        if cartItems.indices.contains(index) {
            let entity = cartItems[index]
            interactor.updateProductQuantity(entity, action: changeAction)
            
            viewWillAppear()
        }
    }
    
    func showEditAddress() {
        router.showEditAddress(completion: { [weak self] newAddress in
            if newAddress.isEmpty == true {
                self?.router.showAlertError("Address is not be empty")
            } else {
                self?.interactor.updateDeliveryAddress(newAddress)
                self?.viewWillAppear()
            }
        })
    }
    
    func processCheckout() {
        let deliveryAddress = interactor.getDeliveryAddress()
        var products: [Product] = []
        for item in cartItems {
            for _ in 0 ..< item.quantity {
                let product = item.convertProductForAPI()
                products.append(product)
            }
        }
        let order = Order(products: products, deliveryAddress: deliveryAddress)
        router.showLoadingIndicator()
        storeInteractor.order(order) { result in
            switch result {
            case .success(let success):
                if success == true {
                    let isPrdDeleted = self.interactor.deleteAllCartProducts()
                    if isPrdDeleted == true {
                        DispatchQueue.main.async {
                            self.router.removeLoadingView()
                            self.router.showCheckoutSuccessView()
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.router.removeLoadingView()
                    self.router.showAlertError(error.message)
                }
            }
        }
    }
}
