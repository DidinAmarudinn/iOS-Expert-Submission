//
//  GameResponse.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 26/02/23.
//

import Foundation

struct GamesResponses: Codable {
    let results: [GameResponse]?
}

struct GameResponse: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let genres: [AdditionDataResponse]?
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case genres
    }
}


