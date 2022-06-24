//
//  Category.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/08.
//

import Foundation

struct CategoryResponse: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: String
    let title: String?
    let imageUrl: String?
}
