//
//  RankingCollectionViewCell.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/10.
//

import UIKit

class RankingCollectionTableViewCell: UITableViewCell {
    
    static let identifier = "RankingCollectionTableViewCell"
    
    private var rankings: [RankingData] = [RankingData]()
    
    private let rankingCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let rankingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        rankingCollectionView.register(RankingCollectionViewCell.self, forCellWithReuseIdentifier: RankingCollectionViewCell.identifier)
        rankingCollectionView.showsHorizontalScrollIndicator = false
        return rankingCollectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray2
        contentView.addSubview(rankingCollectionView)
        
        rankingCollectionView.delegate = self
        rankingCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rankingCollectionView.frame = contentView.bounds
    }
    
    public func configure(with rankings: [RankingData]) {
        self.rankings = rankings
        DispatchQueue.main.async { [weak self] in
//            print("configure called \(self!.rankings)")
            self?.rankingCollectionView.reloadData()
        }
    }
}

extension RankingCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCollectionViewCell.identifier, for: indexPath) as? RankingCollectionViewCell else {
            return UICollectionViewCell()
        }


        guard let model = rankings[indexPath.row].image.medium else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankings.count
    }
    
}
