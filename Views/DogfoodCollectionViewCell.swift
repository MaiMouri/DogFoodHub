//
//  DogfoodCollectionViewCell.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/08.
//

import UIKit
import SDWebImage

class DogfoodCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DogfoodCollectionViewCell"
    
    private let posterImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.awakeFromNib()
        posterImageView.frame = contentView.bounds
    }

    public func configure(with model: String) {
        guard let url = URL(string: model) else {return}
//        print(url)
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
