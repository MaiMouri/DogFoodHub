//
//  YoutubeSearchResponse.swift
//  DogFoodHub
//
//  Created by Mai Mouri on 2022/06/13.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
