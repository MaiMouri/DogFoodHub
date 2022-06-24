//
//  ClipsViewController.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/05.
//

import UIKit
import CoreData


class ClipsViewController: UIViewController {
    
    private var dogfoods: [DogfoodItem] = [DogfoodItem]()
    
    private let clippedTable: UITableView = {
        
        let table = UITableView()
        table.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        title = "Clips"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(clippedTable)
        clippedTable.delegate = self
        clippedTable.dataSource = self
        
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("clipped"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    private func fetchLocalStorageForDownload() {
        
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let dogfoods):
                self?.dogfoods = dogfoods
                DispatchQueue.main.async {
                    self?.clippedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        clippedTable.frame = view.bounds
    }
    
    
}


extension ClipsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogfoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as? RankingTableViewCell else {
            return UITableViewCell()
        }
        
        let dogfood = dogfoods[indexPath.row]
        cell.configure(with: RankingViewModel(titleName: (dogfood.name ?? dogfood.name) ?? "Unknown title name", imageUrl: dogfood.imageUrl ?? ""))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: dogfoods[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Deleted from the database")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.dogfoods.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dogfood = dogfoods[indexPath.row]
        
        guard let titleName = dogfood.name else {
            return
        }
        
        let vc = DogfoodDetailViewController()
        vc.configure(with: DogfoodDetailViewModel(name: titleName, imgageView: dogfood.imageUrl ?? "", dogfoodDetail: dogfood.details ?? ""))
        vc.selectedDogfood = dogfood
        self.navigationController?.pushViewController(vc, animated: true)
        
//        NetWorkingService.shared.getProduct(with: titleName) { [weak self] result in
//            switch result {
//            case .success(let videoElement):
//                DispatchQueue.main.async {
//                    let vc = DogfoodDetailViewController()
//                    vc.configure(with: DogfoodDetailViewModel(name: titleName, imgageView: dogfood.imageUrl ?? "", dogfoodDetail: dogfood.details ?? ""))
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    
    
}
