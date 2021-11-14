//
//  ItemsCell.swift
//  Classifieds
//
//  Created by sami shoaib on 11/11/2021.
//

import UIKit
import NetworkLayer

class ItemsCell: UITableViewCell {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    var data: GetItemList?
    
    static let reuseIdentifier = "ItemsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindCollectionView()
        // Initialization code
    }
    
    private func bindCollectionView() {
        imageCollectionView.register(UINib(nibName: ImageCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupContentData(data: GetItemList?) {
        nameLbl.text = data?.name
        priceLbl.text = data?.price
        self.data = data
        self.imageCollectionView.reloadData()
        
    }
}

extension ItemsCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data?.image_ids.count ?? 0
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        
        if let url = URL(string: self.data?.image_urls_thumbnails[indexPath.row] ?? "") {
            cell.thumnailImg.setImage(from: url, contentMode: .scaleAspectFit)
        }
        
        return cell
    }
}
