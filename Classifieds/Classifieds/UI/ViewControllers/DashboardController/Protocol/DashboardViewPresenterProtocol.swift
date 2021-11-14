import UIKit
import NetworkLayer

// MARK: - AddToBasketTableViewControllerProtocol
protocol DashboardViewPresenterProtocol: class {
    
    var view: DashboardViewControllerProtocol? { get set }
    var items: [GetItemList]? { get set }
    
    func getAmazonList()
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    func didSelectRowAt(indexPath: IndexPath)
    func getDataModelForCell(indexPath: IndexPath) -> GetItemList?
    
}
