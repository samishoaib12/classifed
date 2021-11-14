
import Foundation
import UIKit
import NetworkLayer

protocol DashboardViewControllerProtocol: class {
    var presenter: DashboardViewPresenterProtocol! { get }
    
    func reloadData()
    func showActivityIndicatorOverFullScreen()
    func hideActivityIndicatorOverFullScreen()

}

