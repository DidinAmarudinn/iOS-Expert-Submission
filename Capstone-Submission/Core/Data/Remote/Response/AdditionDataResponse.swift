//
//  AdditionDataResponse.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 01/03/23.
//

import Foundation
struct AdditionDataResponse: Codable {
    let id: Int?
    let name: String?
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
