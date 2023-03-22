//
//  Endpoint.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 26/02/23.
//

import Foundation

struct API {
    static let baseUrl = "https://api.rawg.io/api/"
    static let apiKey = "4fea87291bcd4a5fbc978dcc3d1453f8"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case listGames
        case detailGame(id: Int)
        case detail
        public var url: String {
            switch self {
            case .listGames:
                return "\(API.baseUrl)games?key=\(API.apiKey)"
            case .detailGame(let id):
                return "\(API.baseUrl)games/\(id)?key=\(API.apiKey)"
            case .detail:
                return "\(API.baseUrl)games/\(1004)?key=\(API.apiKey)"
            }
        }
    }
    
}
