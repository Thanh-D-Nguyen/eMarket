//
//  CartRouter.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/27.
//

import UIKit

protocol CartRouterProtocol: AnyObject {
    func dismiss()
    func showAlertError(_ message: String)
    func showCheckoutSuccessView()
    
    func showLoadingIndicator()
    func removeLoadingView()
    func showEditAddress(completion: ((String) -> Void)?)
}

class CartRouter {
    
    private weak var view: CartView?
    
    private var loadingView: LoadingIndicatorView?
    
    init(view: CartView?) {
        self.view = view
    }
    
    class func startModule() -> CartView {
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "CartView") as? CartView else {
            assertionFailure("Can't load cart view")
            return CartView()
        }
        let router = CartRouter(view: view)
        let interactor = CartInteractor()
        let presenter = CartPresenter(router: router, view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
    
}

extension CartRouter: CartRouterProtocol {
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    func showAlertError(_ message: String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message:  message, preferredStyle: .alert)
        let retryAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(retryAction)
        view?.present(alert, animated: true, completion: nil)
    }
    
    func showCheckoutSuccessView() {
        if let superView = view?.view {
            let successView = CheckoutSuccessView(frame: superView.bounds)
            successView.delegate = view
            superView.addSubview(successView)
        }
    }
    
    func showLoadingIndicator() {
        guard let superView = view?.view else { return }
        if loadingView == nil {
            loadingView = LoadingIndicatorView(frame: superView.bounds)
            superView.addSubview(loadingView!)
        }
    }
    
    func removeLoadingView() {
        loadingView?.removeFromSuperview()
    }
    
    func showEditAddress(completion: ((String) -> Void)?) {
        guard let superView = view?.view else { return }
        let addressEditView = EditAddressView(frame: superView.bounds)
        addressEditView.completionHandler = completion
        superView.addSubview(addressEditView)
        addressEditView.startKeyboard()
    }
}
