//
//  ImageCell.swift
//  Classifieds
//
//  Created by sami shoaib on 11/11/2021.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var thumnailImg: CustomImageView!
    
    static let reuseIdentifier = "ImageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
