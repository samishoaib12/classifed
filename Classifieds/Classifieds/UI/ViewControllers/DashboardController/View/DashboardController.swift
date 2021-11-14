//
//  ViewController.swift
//  Classifieds
//
//  Created by sami shoaib on 10/11/2021.
//

import UIKit

class DashboardController: UIViewController {

    @IBOutlet weak var itemTableView: UITableView!
    var presenter:DashboardViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        // Do any additional setup after loading the view.
        self.presenter.getAmazonList()
    }

    private func bindTableView() {
        itemTableView.register(UINib(nibName: ItemsCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ItemsCell.reuseIdentifier)
    }
}

extension DashboardController: DashboardViewControllerProtocol {
    
    func reloadData() {
        self.itemTableView.reloadData()
    }
    
    func showActivityIndicatorOverFullScreen() {
        ActivityIndicatorOverFullScreen.shared.start(onView: self.view)
    }
    
    func hideActivityIndicatorOverFullScreen() {
        ActivityIndicatorOverFullScreen.shared.stop()
    }
}

extension DashboardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowsInSection(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemsCell.reuseIdentifier) as? ItemsCell else { return UITableViewCell() }
        cell.setupContentData(data: presenter.getDataModelForCell(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRowAt(indexPath: indexPath)
    }
    
}
