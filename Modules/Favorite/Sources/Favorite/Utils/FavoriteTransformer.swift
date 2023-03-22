//
//  File.swift
//  
//
//  Created by didin amarudin on 20/03/23.
//

import Foundation
import Core

public struct FavoriteTransformer: Mapper {
    
    
    public typealias Entity = [GameEntityCore]
    public typealias Domain = [GameDomainModel]
    public typealias Request = Any
    public typealias Response = Any
    
    public func transformEntityToDomain(entity: [GameEntityCore]) -> [GameDomainModel] {
        return entity.map { result in
            return GameDomainModel(id: result.id,
                             slug: "", name: result.name,
                             released: result.released,
                             tba: false,
                             backgroundImage: result.backgroundImage,
                             rating: result.rating,
                             ratingTop: 0,
                             genres: [],
                             gameDesc: "",
                             isFavorite: false,
                             tags: [])
        }
    }
    
    public init() {}
    
    public func transformResponseToEntity(response: Response) -> [Core.GameEntityCore] {
        fatalError()
    }
    
    public func transformResponseToDomain(response: Response) -> [Core.GameDomainModel] {
        fatalError()
    }
    
    public func transformerWithRequestResponseToDomains(request: Request, response: Response) -> [Core.GameDomainModel] {
        fatalError()
    }
    
    public func transformDomainToEntity(domain: [Core.GameDomainModel]) -> [Core.GameEntityCore] {
        fatalError()
    }
}
