//
//  HeroHeaderUIView.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/05.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Detail", for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth  = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth  = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        return button
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "hero")
        return imageView
        
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
//        addGradient()
        addSubview(playButton)
        addSubview(detailsButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let detailsButtonConstraints = [
            detailsButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -70),
            detailsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            detailsButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(detailsButtonConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
