//
//  SearchResponse.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/13.
//

import Foundation
struct SearchResponse: Codable {
    
    var hits: [Product]

}

struct Product: Codable {
    var name: String
    var url: String
    var description: String?
    var image: ProductImage
    var review: ProductReview
    var price: Int
    var janCode: String?
}

struct ProductImage: Codable {
    var medium: String
}

struct ProductReview: Codable {
    var rate: Double
    var count: Int
}

