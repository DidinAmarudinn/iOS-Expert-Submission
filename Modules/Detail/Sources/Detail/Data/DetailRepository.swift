//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core
import Combine
public struct DetailRepository<DetailLocalDataSource: LocalDataSource,DetailRemoteDataSource: DataSource, Transformer: Mapper>: Repository
where DetailRemoteDataSource.Response == DetailGameResponse,DetailRemoteDataSource.Request == Int, DetailLocalDataSource.Response == GameEntityCore, Transformer.Domain == GameDomainModel, Transformer.Response == DetailGameResponse, Transformer.Entity == GameEntityCore, Transformer.Request == Bool {
    
    
    public typealias Request = Int
    public typealias Response = GameDomainModel
    
    private let _localeDataSource: DetailLocalDataSource
    private let _remoteDataSource: DetailRemoteDataSource
    private let _mapper: Transformer
    
    public init(localeDataSource: DetailLocalDataSource, remoteDataSource: DetailRemoteDataSource, mapper: Transformer) {
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<GameDomainModel, Error> {
        return _remoteDataSource.execute(request: request)
            .flatMap{ data in
                self._localeDataSource.get(id: data.id ?? 0).map { isfavorite in
                    _mapper.transformerWithRequestResponseToDomains(request: isfavorite, response: data)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
