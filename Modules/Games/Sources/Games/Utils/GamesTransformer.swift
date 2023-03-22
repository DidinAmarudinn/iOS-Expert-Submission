//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core
public struct GamesTransformer: Mapper {
    public func transformDomainToEntity(domain: [Core.GameDomainModel]) -> Entity {
        fatalError()
    }
    
    public typealias Response = [GameResponse]
    public typealias Domain = [GameDomainModel]
    public typealias Entity = Any
    public typealias Request = Any
    
    
    public func transformResponseToEntity(response: [GameResponse]) -> Entity {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: Entity) -> [GameDomainModel] {
        fatalError()
    }
    
    public func transformerWithRequestResponseToDomains(request: Request, response: [GameResponse]) -> [GameDomainModel] {
        fatalError()
    }
    
    
    public init() {}
    
    public func transformResponseToDomain(response: [GameResponse]) -> [GameDomainModel] {
        return response.map { result in
            var genres: [AdditionDomainDataModel] = []
            if let genresData = result.genres {
                for genre in genresData {
                    let genre = AdditionDomainDataModel(id: genre.id ?? 0, name: genre.name ?? "",
                                                  slug: genre.slug ?? "", gamesCount: genre.gamesCount ?? 0,
                                                  imageBackground: genre.imageBackground ?? "")
                    genres.append(genre)
                }
            }
            let games = GameDomainModel(id: result.id ?? 0,
                                  slug: result.slug ?? "",
                                  name: result.name ?? "",
                                  released: result.released ?? "",
                                  tba: result.tba ?? false,
                                  backgroundImage: result.backgroundImage ?? "",
                                  rating: result.rating ?? 0.0,
                                  ratingTop: result.ratingTop ?? 0,
                                  genres: genres,
                                  gameDesc: "",
                                  isFavorite: false,
                                  tags: [])
            return games
        }
    }
    
    
}
