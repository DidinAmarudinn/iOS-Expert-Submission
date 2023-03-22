//
//  RemoteDataSource.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 26/02/23.
//

import Alamofire
import Combine
import Foundation
protocol RemoteDataSourceProtocol: AnyObject {
    func getGames() -> AnyPublisher<[GameResponse], Error>
    func getDetailGames(id: Int) -> AnyPublisher<DetailGameResponse, Error>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGames() -> AnyPublisher<[GameResponse], Error> {
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
    
    func getDetailGames(id: Int) -> AnyPublisher<DetailGameResponse, Error> {
        return Future<DetailGameResponse, Error> { completion in
            if let url = URL(string: Endpoints.Gets.detailGame(id: id).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailGameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
            
        }.eraseToAnyPublisher()
    }
}
