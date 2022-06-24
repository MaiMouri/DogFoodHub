//
//  Dogfood.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/06.
//

import Foundation

struct DogfoodResponse: Codable {
    let dogfoods: [Dogfood]
}

struct Dogfood: Codable {
    let id: Int
    let name: String
    let content: Int
    let brand: String
    let category: String
    let lifeStage: String
    let ingredients: String
    let description: String
    let madeIn: String
    let foodType: String
    let imageUrl: String?
    let url: String?
    let price: Int
    let sku: String
    let calories:Int?
    let nutrition: Nutrition?

}

struct Nutrition: Codable {
    let protein: Float
    let fat: Float
    let fiber: Float
    let calcium: Float
    let moisture: Float
}


