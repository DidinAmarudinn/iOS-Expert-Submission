//
//  File 2.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core

public struct DetailGameTransformer: Mapper {
 
    public typealias Response = DetailGameResponse
    
    public typealias Entity = GameEntityCore
    
    public typealias Domain = GameDomainModel
    
    public typealias Request = Bool
    
    public init() {}
    
    public func transformerWithRequestResponseToDomains(request: Bool, response: DetailGameResponse) -> GameDomainModel {
        var genres: [AdditionDomainDataModel] = []
        if let genresData = response.genres {
            for genre in genresData {
                let genre = AdditionDomainDataModel(id: genre.id ?? 0, name: genre.name ?? "",
                                              slug: genre.slug ?? "", gamesCount: genre.gamesCount ?? 0,
                                              imageBackground: genre.imageBackground ?? "")
                genres.append(genre)
            }
        }
        var tags: [AdditionDomainDataModel] = []
        if let tagsData = response.tags {
            for tag in tagsData {
                let genre = AdditionDomainDataModel(id: tag.id ?? 0, name: tag.name ?? "",
                                              slug: tag.slug ?? "", gamesCount: tag.gamesCount ?? 0,
                                              imageBackground: tag.imageBackground ?? "")
                tags.append(genre)
            }
        }
        let game = GameDomainModel(id: response.id ?? 0,
                             slug: response.slug ?? "",
                             name: response.name ?? "",
                             released: response.released ?? "",
                             tba: response.tba ?? false,
                             backgroundImage: response.backgroundImage ?? "",
                             rating: response.rating ?? 0,
                             ratingTop: response.ratingTop ?? 0,
                             genres: genres,
                             gameDesc: response.descriptionRaw ?? "",
                             isFavorite: request,
                             tags: tags)
        return game
    }
    
    public func transformResponseToEntity(response: DetailGameResponse) -> GameEntityCore {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: GameEntityCore) -> GameDomainModel {
        fatalError()
    }
    
    public func transformResponseToDomain(response: DetailGameResponse) -> GameDomainModel {
        fatalError()
    }
    
    public func transformDomainToEntity(domain: GameDomainModel) -> GameEntityCore {
        let entity = GameEntityCore()
        entity.id = domain.id
        entity.name = domain.name
        entity.rating = domain.rating
        entity.backgroundImage = domain.backgroundImage
        entity.released = domain.released
        return entity
    }
}
