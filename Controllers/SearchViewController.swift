//
//  SearchViewController.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/05.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var dogfoods: [Dogfood] = [Dogfood]()
    public var products: [Product] = [Product]()

    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Dogfood or a Treats"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.tintColor = .systemTeal
        fetchDiscoverDogfoods()
        
        searchController.searchResultsUpdater = self
    }
    
    private func fetchDiscoverDogfoods() {
        NetWorkingService.shared.getDiscoverDogfoods { [weak self] result in
            switch result {
            case .success(let dogfoods):
                self?.dogfoods = dogfoods
                DispatchQueue.main.async {
                    self?.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogfoods.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as? RankingTableViewCell else {
            return UITableViewCell()
        }
        
        
        let dogfood = dogfoods[indexPath.row]
        let model = RankingViewModel(titleName: dogfood.name, imageUrl: dogfood.imageUrl ?? "")
        cell.configure(with: model)
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let product = products[indexPath.row]
        
        let titleName = product.name
        
        NetWorkingService.shared.getProduct(with: titleName) { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async {
//                    let vc = TitlePreviewViewController()
//                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                  return
              }
        resultsController.delegate = self

        NetWorkingService.shared.searchData(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dogfoods):
                    resultsController.dogfoods = dogfoods
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        // Yahoo検索
//        NetWorkingService.shared.search(with: query) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let products):
//                    resultsController.products = products
//                    resultsController.searchResultsCollectionView.reloadData()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
    }
    
    
    
    func searchResultsViewControllerDidTapItem(_ viewModel: DogfoodDetailViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = DogfoodDetailViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
