//
//  ActivityIndicatorOverFullScreen.swift

import UIKit

enum ActivityIndicatorOverFullScreenAction {
    case start
    case stop
}

final class ActivityIndicatorOverFullScreen: NSObject {
    
    static let shared = ActivityIndicatorOverFullScreen()
    
    private let backgroundView = UIView()
    private let viewWithIndicator = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private var loadingCount = 0
    
    func start(onView view: UIView) {
        if loadingCount == 0 {
            self.showIndicator(onView: view)
        }
        loadingCount += 1
    }
    
    func stop() {
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            self.removeIndicator()
        }
    }
    
    private func prepareUI() {
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6) //black.withAlphaComponent(0.6)
        activityIndicator.style = .medium
        activityIndicator.color = UIColor.black
        viewWithIndicator.backgroundColor = UIColor.darkGray
        viewWithIndicator.layer.cornerRadius = 8
    }
    
    private func showIndicator(onView view: UIView) {
        self.prepareUI()
        
        view.addSubview(self.backgroundView)
        self.backgroundView.addSubview(self.viewWithIndicator)
        self.viewWithIndicator.addSubview(self.activityIndicator)
        
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.viewWithIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.viewWithIndicator.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor).isActive = true
        self.viewWithIndicator.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor).isActive = true
        self.viewWithIndicator.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.viewWithIndicator.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.topAnchor.constraint(equalTo: self.viewWithIndicator.topAnchor, constant: 10).isActive = true
        self.activityIndicator.leftAnchor.constraint(equalTo: self.viewWithIndicator.leftAnchor, constant: 10).isActive = true
        self.activityIndicator.rightAnchor.constraint(equalTo: self.viewWithIndicator.rightAnchor, constant: -10).isActive = true
        self.activityIndicator.bottomAnchor.constraint(equalTo: self.viewWithIndicator.bottomAnchor, constant: -10).isActive = true
        
        self.activityIndicator.startAnimating()
    }
    
    private func removeIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.backgroundView.removeFromSuperview()
        }
    }
    
}
