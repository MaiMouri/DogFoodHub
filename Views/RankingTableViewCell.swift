//
//  RankingTableViewCell.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/13.
//

import UIKit
import SDWebImage

class RankingTableViewCell: UITableViewCell {
    
    static let identifier = "RankingTableViewCell"

    private let gotoPageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(gotoPageButton)
        
        applyConstraints()
        
    }
    
    private func applyConstraints() {
            let titlesPosterUIImageViewConstraints = [
                titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
            ]
            
            
            let nameLabelConstraints = [
                nameLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
            
            
            let gotoPageButtonConstraints = [
                gotoPageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                gotoPageButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
            
            NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
            NSLayoutConstraint.activate(nameLabelConstraints)
            NSLayoutConstraint.activate(gotoPageButtonConstraints)
        }
        
        
        
        public func configure(with model: RankingViewModel) {

            guard let url = URL(string: model.imageUrl) else {
                return
            }
            titlesPosterUIImageView.sd_setImage(with: url, completed: nil)
            nameLabel.text = model.titleName
        }
        
        
        
        required init?(coder: NSCoder) {
            fatalError()
        }
}
