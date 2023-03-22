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

public struct DetailGameRemoteDataSource: DataSource {
    public typealias Response = DetailGameResponse
    public typealias Request = Int
        
    public init () {}
    
    public func execute(request: Int?) -> AnyPublisher<DetailGameResponse, Error> {
        return Future<DetailGameResponse, Error> { completion in
            if let url = URL(string: Endpoints.Gets.detailGame(id: request ?? 0).url) {
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
