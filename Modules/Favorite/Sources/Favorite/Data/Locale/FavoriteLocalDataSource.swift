//
//  File.swift
//  
//
//  Created by didin amarudin on 20/03/23.
//

import Foundation
import Core
import RealmSwift
import Combine

public struct FavoriteLocalDataSource: LocalDataSource {
    
    public typealias Request = Any
    public typealias Response = GameEntityCore
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    
    public func list(request: Any?) -> AnyPublisher<[GameEntityCore], Error> {
        return Future<[GameEntityCore], Error> { completion in
            let games: Results<GameEntityCore> = {
                _realm.objects(GameEntityCore.self)
            }()
            completion(.success(games.toArray(ofType: GameEntityCore.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entity: Core.GameEntityCore) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func delete(entity: Core.GameEntityCore) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    
}
