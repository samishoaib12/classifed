//
//  CustomImageView.swift
//  Classifieds
//
//  Created by sami shoaib on 12/11/2021.
//

import UIKit

class CustomImageView: UIImageView {
    let imageCache = NSCache<AnyObject, AnyObject>()
    var ImageUrlString: URL?
        
    func setImage(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            contentMode = mode
            ImageUrlString = url
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
                self.image = imageFromCache as? UIImage
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let imageToCache = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    if self.ImageUrlString == url {
                        self.image = imageToCache
                    }
                    self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
            }.resume()
        }
    func setImage(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            setImage(from: url, contentMode: mode)
        }
}
