//
//  TitlePreviewViewController.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/13.
//

import UIKit
import WebKit
import SDWebImage
import CoreData

class DogfoodDetailViewController: UIViewController {
    
    private var reviews:[DogfoodReview] = [DogfoodReview]()
    
    var selectedDogfood: DogfoodItem? {
        didSet {
            loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//MARK: - Data Manupulation
    
    func loadItems(with request: NSFetchRequest<DogfoodReview> = DogfoodReview.fetchRequest()) {
        
        let predicate = NSPredicate(format: "parentDogfoodItem.name MATCHES %@", selectedDogfood!.name!)
        
        request.predicate = predicate
        do {
            reviews = try context.fetch(request)
        } catch {
            print("Error fetching data from CoreData \(error)")
        }
        reviewTable.reloadData()
    }
    
    func saveReviews() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.reviewTable.reloadData()
    }
    
//MARK: - Components
    
    private let reviewTable: UITableView = {
        let table = UITableView()
        table.register(UINib(nibName: ReviewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ReviewsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    private let titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.text = "Royal Canin"
        return label
    }()
    
    private let detailLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "This is the best dogfood ever for my dog!"
        return label
    }()
    
    private let clipButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemTeal
        button.setTitle("📋 Review", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(button.self, action: #selector(onAddButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let dogfoodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(dogfoodImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        view.addSubview(clipButton)
        view.addSubview(reviewTable)
//        configureNavbar()

        reviewTable.delegate = self
        reviewTable.dataSource = self
        configureConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reviewTable.frame = CGRect(x: 0, y: Int(clipButton.frame.maxY)+50, width: Int(view.frame.width), height: 200)
    }
    
//    private func configureNavbar() {
//
//        navigationItem.rightBarButtonItem =
//        UIBarButtonItem(image: UIImage(systemName: "pawprint.fill"), style: .done, target: self, action: #selector(onAddButtonPressed(_:)))
//
//        navigationController?.navigationBar.tintColor = .brown
//    }
    
    @objc func onAddButtonPressed(_ sender: UIButton){
        var textField = UITextField()
        var scoreField = UITextField()
        let alert = UIAlertController(title: "Add New Review", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Review", style: .default){ (action) in
            let newReview = DogfoodReview(context: self.context)
            newReview.content = textField.text!
            newReview.stars = Int16(scoreField.text!)!
            newReview.date = Date()
            newReview.parentDogfoodItem = self.selectedDogfood
            self.reviews.append(newReview)
            self.saveReviews()
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        alert.addAction(
                UIAlertAction(title: "Cancel", style: .cancel))
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "Write a Review"
            textField = alertTextField
        }
        alert.addTextField{(alertScoreField) in
            alertScoreField.placeholder = "Enter: 1-5"
            scoreField = alertScoreField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

    
    func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        let imageViewConstraints = [
            dogfoodImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            dogfoodImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dogfoodImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dogfoodImageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let detailLabelConstraints = [
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            detailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let clipButtonConstraints = [
            clipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clipButton.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 25),
            clipButton.widthAnchor.constraint(equalToConstant: 140),
            clipButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let reviewTableConstraints = [
            reviewTable.topAnchor.constraint(equalTo: clipButton.bottomAnchor, constant: 50),
            reviewTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)

        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(detailLabelConstraints)
        NSLayoutConstraint.activate(clipButtonConstraints)
        NSLayoutConstraint.activate(reviewTableConstraints)

    }
    
    
    public func configure(with model: DogfoodDetailViewModel) {
        titleLabel.text = model.name
        detailLabel.text = model.dogfoodDetail
        dogfoodImageView.sd_setImage(with: model.imgageView.asUrl, completed: nil)
//        dishImageView.kf.setImage(with: dish.image?.asUrl)
//        guard let url = URL(string: "https://www.youtube.com/embed/") else {
//            return
//        }
//
//        webView.load(URLRequest(url: url))
    }

}

extension DogfoodDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath) as? ReviewsTableViewCell else {
            return UITableViewCell() }

        let review = reviews[indexPath.row]
        cell.configure(review: review)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
