//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core
import RealmSwift
import Combine

public struct DetailGameLocalDataSource: LocalDataSource {
    public typealias Request = Any
    public typealias Response = GameEntityCore
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func add(entity: GameEntityCore) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.add(entity, update: .all)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    
    public func list(request: Request?) -> AnyPublisher<[GameEntityCore], Error> {
        fatalError()
    }
    
    public func delete(entity: GameEntityCore) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    _realm.add(entity, update: .modified)
                    _realm.delete(entity)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            let result = _realm.object(ofType: GameEntityCore.self, forPrimaryKey: id)
            completion(.success(result != nil))
        }.eraseToAnyPublisher()
    }
    
    
}
