//
//  ReviewsTableViewCell.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/16.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewsTableViewCell"

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var starsLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func configure(review: DogfoodReview){
        let stars = String(repeating:"⭐️", count:Int(review.stars))
        contentLbl.text = review.content
        starsLbl.text = stars
        dateLbl.text = review.date?.asStringDate

    }
    
}
