//
//  LifeStage.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/08.
//

import Foundation

struct LifeStageResponse: Codable {
    let lifeStages: [LifeStage]
}

struct LifeStage: Codable {
    let id: String
    let title: String?
    let imageUrl: String?
}
