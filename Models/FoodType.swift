//
//  FoodType.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/17.
//

import Foundation

struct FoodTypeResponse: Codable {
    let foodTypes: [FoodType]
}

struct FoodType: Codable {
    let id: String
    let title: String?
    let imageUrl: String?
}
