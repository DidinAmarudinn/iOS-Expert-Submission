//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core
import Combine
import Alamofire
public struct GetGamesRemoteDataSource: DataSource {
    public typealias Request = Any
    public typealias Response = [GameResponse]
    
    public init() {}
    
    public func execute(request: Request?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.listGames.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponses.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results ?? []))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    

}
