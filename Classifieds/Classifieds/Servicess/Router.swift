
//  Router.swift

import UIKit
import NetworkLayer

/**
 Class responsible for navigation in the application
 */

protocol RouterProtocol {
    
    //MARK:- Dashboard Flow
    func showDashboardViewController()
    
}

final class Router: NSObject {
    static let shared = Router()
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

}

extension Router: RouterProtocol {
    
    //MARK:- Dashboard Flow
    func showDashboardViewController() {
        let dashboardController = DashboardController()
        let presenter = DashboardViewPresenter(view: dashboardController)
        dashboardController.presenter = presenter
        
        self.window?.rootViewController = dashboardController
        self.window?.makeKeyAndVisible()
    }
    
   
}
