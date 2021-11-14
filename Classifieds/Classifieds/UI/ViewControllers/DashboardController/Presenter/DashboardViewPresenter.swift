import NetworkLayer

final class DashboardViewPresenter: DashboardViewPresenterProtocol {
    
    weak var view: DashboardViewControllerProtocol?
    var items: [GetItemList]?
    
    init(view: DashboardViewControllerProtocol?) {
        self.view = view
    }
    
    func getAmazonList() {
        self.view?.showActivityIndicatorOverFullScreen()
        NetworkManager.shared.getAmazonList { (itemlist,responseError) in
            self.view?.hideActivityIndicatorOverFullScreen()
            if let error = responseError {
                switch error {
                case .unKnownError:
                break
                default: break
                }
            } else if let items = itemlist {
                DispatchQueue.main.async { [weak self] in
                    guard let sself = self else { return }
                    sself.items = items.results;
                    sself.view?.reloadData()
                }
            } else {

            }
        }
  
    }
    
    func getDataModelForCell(indexPath: IndexPath) -> GetItemList? {
        return self.items?[indexPath.row]
    }
    
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        
    }
    
}
