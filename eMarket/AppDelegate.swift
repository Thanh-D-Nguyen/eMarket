//
//  AppDelegate.swift
//  eMarket
//
//  Created by Nguyen Van Thanh on 2021/11/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppService.bootstrap()
        let loadingView = LoadingRouter.startModule()
        window?.rootViewController = loadingView
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        StoreDataManagement.shared.saveContext()
    }
}

