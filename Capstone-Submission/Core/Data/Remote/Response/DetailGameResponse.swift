//
//  DetailGameResponse.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 01/03/23.
//

import Foundation

struct DetailGameResponse: Codable {
    var id: Int?
    var slug: String?
    var name: String?
    var released: String?
    var tba: Bool?
    var updated: String?
    var ratingTop: Int?
    var backgroundImage: String?
    var website: String?
    var rating: Double?
    var reviewsCount: Int?
    var genres: [AdditionDataResponse]?
    var tags: [AdditionDataResponse]?
    var publishers: [AdditionDataResponse]?
    var descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case tba
        case ratingTop = "rating_top"
        case updated
        case backgroundImage = "background_image"
        case website
        case rating
        case reviewsCount = "reviews_count"
        case genres, tags, publishers
        case descriptionRaw = "description_raw"
    }
}
