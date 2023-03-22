//
//  GameModel.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import Foundation
struct GameModel: Equatable, Identifiable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let genres: [AdditionDataModel]
    let gameDesc: String
    let isFavorite: Bool 
    let tags: [AdditionDataModel]
}

struct AdditionDataModel: Equatable, Identifiable  {
    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    let imageBackground: String
}


