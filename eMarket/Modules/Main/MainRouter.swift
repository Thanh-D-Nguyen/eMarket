//
//  MainRouter.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/26.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    func showCartView()
    func showAlertError(_ message: String, retryAction: (() -> Void)?)
    
    func showLoadingIndicator()
    func removeLoadingView()
}

class MainRouter {
    
    private weak var mainView: MainView?
    private var loadingView: LoadingIndicatorView?

    init(view: MainView?) {
        self.mainView = view
    }
    
    class func startModule() -> MainView {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "MainView") as? MainView else {
            assertionFailure("Can't load main view")
            return MainView()
        }
        let router = MainRouter(view: view)
        let interactor = StoreInteractor()
        let presenter = MainPresenter(router: router, view: view, interactor: interactor)
        view.presenter = presenter
        return view
    }
}

extension MainRouter: MainRouterProtocol {
    func showCartView() {
        let cartView = CartRouter.startModule()
        cartView.modalPresentationStyle = .fullScreen
        mainView?.present(cartView, animated: true, completion: nil)
    }
    
    func showAlertError(_ message: String, retryAction: (() -> Void)?) {
        let alert: UIAlertController = UIAlertController(title: "Error", message:  message, preferredStyle: .alert)
        let retryAction: UIAlertAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in
            retryAction?()
        })
        alert.addAction(retryAction)
        mainView?.present(alert, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        guard let superView = mainView?.view else { return }
        if loadingView == nil {
            loadingView = LoadingIndicatorView(frame: superView.bounds)
            superView.addSubview(loadingView!)
        }
    }
    
    func removeLoadingView() {
        loadingView?.removeFromSuperview()
    }
}
