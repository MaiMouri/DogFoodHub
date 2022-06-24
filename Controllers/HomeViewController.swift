//
//  HomeViewController.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/05.
//

import UIKit

enum Sections: Int {
    case Dogfoods = 0
    case Categories = 1
    case FoodType = 2
    case Ranking = 3
}

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["DogFood", "Categories", "foodtype", "Ranking"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 300), style: .grouped)
 
        table.separatorStyle = .none
       
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        table.register(RankingCollectionTableViewCell.self, forCellReuseIdentifier: RankingCollectionTableViewCell.identifier)
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        table.register(FoodTypeTableViewCell.self, forCellReuseIdentifier: FoodTypeTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBrown
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 250))
        homeFeedTable.tableHeaderView = headerView
        
        //        fetchData()
        
        NetWorkingService.shared.getRanking{_ in}
    }
    
    private func configureNavbar() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        menuBtn.setImage(UIImage(named:"DogFoodHub-logo"), for: .normal)
        menuBtn.addTarget(self, action: #selector(onMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 42)
            currWidth?.isActive = true
            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 42)
            currHeight?.isActive = true
        navigationItem.leftBarButtonItem = menuBarItem
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "pawprint.fill"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .brown
    }
    
    @objc func onMenuButtonPressed(_ sender: UIBarButtonItem){
        print("HOME")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func fetchData(){
        NetWorkingService.shared.getDogfood{ results in
            switch results {
                
            case .success(let dogfoods):
                print(dogfoods)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case Sections.Dogfoods.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell
            cell!.delegate = self
            NetWorkingService.shared.getDogfood{ result in
                switch result {
                case .success(let dogfoods):
                    cell?.configure(with: dogfoods)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell!
        case Sections.Categories.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell
            
            NetWorkingService.shared.getCategories{ result in
                switch result {
                case .success(let categories):
                    cell?.configure(with: categories)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell!
        case Sections.Ranking.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: RankingCollectionTableViewCell.identifier, for: indexPath) as? RankingCollectionTableViewCell
            
            NetWorkingService.shared.getRanking{ result in
                switch result {
                case .success(let rankings):
                    cell?.configure(with: rankings)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell!
        case Sections.FoodType.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodTypeTableViewCell.identifier, for: indexPath) as? FoodTypeTableViewCell
            
            NetWorkingService.shared.getFoodTypes{ result in
                switch result {
                case .success(let foodTypes):
                    cell?.configure(with: foodTypes)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Sections.Categories.rawValue:
            return 70
        case Sections.FoodType.rawValue:
            return 150
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.capitalizaionFirstLetter()
    }
    
    
    // Hide navBar after scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DogfoodDetailViewModel) {

        DispatchQueue.main.async { [weak self] in
            let vc = DogfoodDetailViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
