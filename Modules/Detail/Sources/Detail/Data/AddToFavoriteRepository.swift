//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core
import Combine
public struct AddToFavoriteRepository<DetailLocalDataSource: LocalDataSource, Transformer: Mapper >: Repository
where DetailLocalDataSource.Response == GameEntityCore, Transformer.Domain == GameDomainModel, Transformer.Entity == GameEntityCore {
    
    
    public typealias Request = GameDomainModel
    public typealias Response = Bool
    
    private let _localeDataSource: DetailLocalDataSource
    private let _mapper: Transformer
    
    public init(localeDataSource: DetailLocalDataSource, mapper: Transformer) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: GameDomainModel?) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.add(entity: _mapper.transformDomainToEntity(domain: request!)).eraseToAnyPublisher()
    }
}

