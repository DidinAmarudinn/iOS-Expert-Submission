//
//  LocalDataSource.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 26/02/23.
//

import Foundation
import RealmSwift
import Combine
protocol LocaleDataSourceProtocol: AnyObject {
    func getFavorites() -> AnyPublisher<[GameEntity], Error>
    func getIsFavorite(withid id: Int) -> AnyPublisher<Bool, Error>
    func addToFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error>
    func removeFromFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error>
}


final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getFavorites() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getIsFavorite(withid id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let result = realm.object(ofType: GameEntity.self, forPrimaryKey: id)
                completion(.success(result != nil))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addToFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeFromFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .modified)
                        realm.delete(game)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()

    }
}


extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
