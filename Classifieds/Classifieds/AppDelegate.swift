//
//  AppDelegate.swift
//  Classifieds
//
//  Created by sami shoaib on 10/11/2021.
//

import UIKit
import NetworkLayer
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkManager.shared.environment = .DEV
        // Override point for customization after application launch.
        Router.shared.showDashboardViewController()
        return true
    }

}

