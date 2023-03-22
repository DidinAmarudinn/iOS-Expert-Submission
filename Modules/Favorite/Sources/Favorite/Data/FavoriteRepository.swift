//
//  File.swift
//  
//
//  Created by didin amarudin on 20/03/23.
//

import Foundation

import Core
import Combine
public struct FavoriteRepository<FavoriteLocalDataSource: LocalDataSource, Transformer: Mapper >: Repository
where FavoriteLocalDataSource.Response == GameEntityCore, FavoriteLocalDataSource.Request == Any, Transformer.Domain == [GameDomainModel], Transformer.Entity == [GameEntityCore] {
   
    public typealias Request = Any
    public typealias Response = [GameDomainModel]
    
    private let _localeDataSource: FavoriteLocalDataSource
    private let _mapper: Transformer
    
    public init(localeDataSource: FavoriteLocalDataSource, mapper: Transformer) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<[Core.GameDomainModel], Error> {
        _localeDataSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}

