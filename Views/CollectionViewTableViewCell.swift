//
//  CollectionTableTableViewCell.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/05.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DogfoodDetailViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    
    private var dogfoods: [Dogfood] = [Dogfood]()
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        layout.sectionInset.left = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DogfoodCollectionViewCell.self, forCellWithReuseIdentifier: DogfoodCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.register(RankingCollectionViewCell.self, forCellWithReuseIdentifier: RankingCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray2
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with dogfoods: [Dogfood]) {
        self.dogfoods = dogfoods
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    public func clipDogFoodAt(indexpath: IndexPath) {
        //        print("Clip! : \(dogfoods[indexpath.row])")
        DataPersistenceManager.shared.clipDogfoodWith(model: dogfoods[indexpath.row]) { result in
            switch result {
            case .success():
                print("SUCCESS")
                NotificationCenter.default.post(name: NSNotification.Name("clipped"), object: nil)
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
}


extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogfoodCollectionViewCell.identifier, for: indexPath) as? DogfoodCollectionViewCell else {
            return UICollectionViewCell()
        }
        //        print("indexpath.section: \(indexPath.section)")
        
        guard let model = dogfoods[indexPath.row].imageUrl else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogfoods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {[weak self] _ in
                let clipAction = UIAction(title: "Clip", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.clipDogFoodAt(indexpath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [clipAction])
            }
        
        return config
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let dogfood = dogfoods[indexPath.row]
        print(dogfood.name)

        let viewModel = DogfoodDetailViewModel(name: dogfood.name, imgageView: dogfood.imageUrl ?? "", dogfoodDetail: dogfood.description)
        self.delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: viewModel)

    }
    
    
}

