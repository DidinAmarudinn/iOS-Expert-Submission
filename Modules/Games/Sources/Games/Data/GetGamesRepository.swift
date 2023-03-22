//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core
import Combine
public struct GetGamesRepository<RemoteData: DataSource, Transformer: Mapper>: Repository where RemoteData.Response == [GameResponse], Transformer.Domain == [GameDomainModel], Transformer.Response == [GameResponse] {
    
    public typealias Request = Any
    public typealias Response = [GameDomainModel]
    
    private let _remoteDataSource: RemoteData
    private let _mapper: Transformer
    
    
    public init(remoteDataSource: RemoteData, mapper: Transformer) {
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> AnyPublisher<[GameDomainModel], Error> {
        return _remoteDataSource.execute(request: nil)
            .map { _mapper.transformResponseToDomain(response: $0) }
            .eraseToAnyPublisher()
    }
    
    
}
