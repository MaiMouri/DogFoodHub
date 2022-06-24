//
//  Ranking.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/08.
//

import Foundation

struct RankingApiResponse: Codable {
    
//    var categoryRanking: CategoryRanking
    
    var category_ranking: CategoryRanking

//    enum CodingKeys:String, CodingKey {
//
//            case categoryRanking = "category_ranking"
//        }
}


struct CategoryRanking: Codable {
    var rankingData: [RankingData]
    enum CodingKeys:String, CodingKey {
            case rankingData = "ranking_data"
        }
}

struct RankingData: Codable {
    var rank: Int
    var name: String
    var url: String
    var image: Image
    var review: Review
}

struct Image: Codable {
    var medium: String?
}

struct Review: Codable {
    var rate: Double
    var count: Int
}
