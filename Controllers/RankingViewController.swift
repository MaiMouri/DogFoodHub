//
//  UpcomingViewController.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/05.
//

import UIKit

class RankingViewController: UIViewController {

    private var rankings: [RankingData] = [RankingData]()
        
        private let upcomingTable: UITableView = {
           
            let table = UITableView()
            table.register(RankingTableViewCell.self, forCellReuseIdentifier: RankingTableViewCell.identifier)
            return table
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            title = "Ranking"
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationItem.largeTitleDisplayMode = .always
            
            
            view.addSubview(upcomingTable)
            upcomingTable.delegate = self
            upcomingTable.dataSource = self
            
            fetchUpcoming()
            
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            upcomingTable.frame = view.bounds
        }
        
        
        
        private func fetchUpcoming() {
            NetWorkingService.shared.getRanking { [weak self] result in
                switch result {
                case .success(let rankings):
                    self?.rankings = rankings
                    DispatchQueue.main.async {
                        self?.upcomingTable.reloadData()
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }


    extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return rankings.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as? RankingTableViewCell else {
                return UITableViewCell()
            }
            
            let ranking = rankings[indexPath.row]
            cell.configure(with: RankingViewModel(titleName: ranking.name, imageUrl: ranking.image.medium ?? ""))
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 140
        }
        

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let ranking = rankings[indexPath.row]
            
            let titleName = ranking.name
            
//            NetWorkingService.shared.getMovie(with: titleName) { [weak self] result in
//                switch result {
//                case .success(let videoElement):
//                    DispatchQueue.main.async {
//                        let vc = TitlePreviewViewController()
//                        vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
//                        self?.navigationController?.pushViewController(vc, animated: true)
//                    }
//                    
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
        }

}
