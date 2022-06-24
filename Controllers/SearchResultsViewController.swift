//
//  SearchResultsViewController.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/13.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: DogfoodDetailViewModel)
}

class SearchResultsViewController: UIViewController {
   
    public var dogfoods: [Dogfood] = [Dogfood]()
    public var products: [Product] = [Product]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DogfoodCollectionViewCell.self, forCellWithReuseIdentifier: DogfoodCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }

}


extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogfoods.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogfoodCollectionViewCell.identifier, for: indexPath) as? DogfoodCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let dogfood = dogfoods[indexPath.row]
        cell.configure(with: dogfood.imageUrl!)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

//        let product = products[indexPath.row]
//        let titleName = product.name
        let dogfood = dogfoods[indexPath.row]
        let titleName = dogfood.name
        print(titleName)
//        NetWorkingService.shared.getMovie(with: titleName) { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                self?.delegate?.searchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: title.original_title ?? "", youtubeView: videoElement, titleOverview: title.overview ?? ""))
//
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        

    }
    
}
