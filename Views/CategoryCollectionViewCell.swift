//
//  CategoryCollectionViewCell.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/11.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    func configure(with model: String, with title: String) {
        guard let url = URL(string: model) else {return}
        
        self.imgView?.sd_setImage(with: url, completed: nil)
        self.titleLbl?.text = title
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}
