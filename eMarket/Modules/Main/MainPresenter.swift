//
//  MainPresenter.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    var productsCount: Int { get }
    func product(at index: Int) -> Product
    
    func viewDidLoad()
    func viewWillAppear()
    
    func addProductToCart(atIndex index: Int)
    func showCartView()
}

class MainPresenter {
    private let interactor: StoreInteractorProtocol
    private let cartInteractor: CartInteractorProtocol
    private let router: MainRouterProtocol
    private let view: MainViewProtocol
    
    private var products: [Product] = []
    
    var productsCount: Int {
        return products.count
    }
    
    init(router: MainRouterProtocol,
         view: MainViewProtocol,
         interactor: StoreInteractorProtocol) {
        self.router = router
        self.view = view
        self.interactor = interactor
        
        cartInteractor = CartInteractor()
    }
    
    private func getStoreInformation() {
        interactor.getStoreInfomation { result in
            switch result {
            case .success(let store):
                DispatchQueue.main.async {
                    self.view.didLoadStore(store)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.router.showAlertError(error.message, retryAction:  { [weak self] in
                        self?.viewWillAppear()
                    })
                }
            }
        }
    }
    
    func getProductsList() {
        router.showLoadingIndicator()
        interactor.getProducts { result in
            switch result {
            case .success(let allProducts):
                if let allProducts = allProducts {
                    self.products = allProducts
                    DispatchQueue.main.async {
                        self.router.removeLoadingView()
                        self.view.didLoadProducts()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.router.removeLoadingView()
                    self.router.showAlertError(error.message, retryAction: { [weak self] in
                        self?.viewWillAppear()
                    })
                }
            }
        }
    }
    
    private func updateCardState(animated: Bool) {
        let products = cartInteractor.getProductsInCart()
        view.didUpdateNumOfProductInCart(products.count, animated: animated)
    }
}

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() { }
    func viewWillAppear() {
        getStoreInformation()
        getProductsList()
        updateCardState(animated: false)
        cartInteractor.didNoticeAddExistedProduct = { [weak self] in
            self?.view.didShowNoticeProductExistInCart()
        }

    }

    func product(at index: Int) -> Product {
        if products.indices.contains(index) {
            return products[index]
        }
        return Product()
    }
    
    func addProductToCart(atIndex index: Int) {
        // use index as product id, define product id for bester
        let product = product(at: index)
        let success = cartInteractor.addToCart(product: product, id: index)
        if success == true {
            updateCardState(animated: true)
        }
    }
    
    func showCartView() {
        router.showCartView()
    }
}
