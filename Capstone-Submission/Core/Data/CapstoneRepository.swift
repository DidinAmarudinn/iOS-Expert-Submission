//
//  CapstoneRepository.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import Foundation
import Combine
protocol CapstoneRepositoryProtocol {
    func getGames() -> AnyPublisher<[GameModel], Error>
    func getDetailGame(id: Int) -> AnyPublisher<GameModel, Error>
    func addToFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func removeFromFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func getListFavoriteGame() -> AnyPublisher<[GameModel], Error>
    
}


final class CapstoneRepository: NSObject {
    
    typealias CapstoneInstance = (LocaleDataSource, RemoteDataSource) -> CapstoneRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: CapstoneInstance = { localeRepo, remoteRepo in
        return CapstoneRepository(locale: localeRepo, remote: remoteRepo)
    }
    
}


extension CapstoneRepository: CapstoneRepositoryProtocol {
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return remote.getGames()
            .map { GameMapper.mapGamesResponseToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getDetailGame(id: Int) -> AnyPublisher<GameModel, Error> {
        return remote.getDetailGames(id: id)
            .flatMap{ data in
                self.locale.getIsFavorite(withid: data.id ?? 0).map { isfavorite in
                    GameMapper.detailGameResponseToDomains(input: data, isFavorite: isfavorite)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getListFavoriteGame() -> AnyPublisher<[GameModel], Error> {
        return locale.getFavorites()
            .map { GameMapper.mapEntitisToDomains(inpit: $0) }
            .eraseToAnyPublisher()
    }
    
    func addToFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return locale.addToFavorite(from: GameMapper.domainsToEntities(input: game)).eraseToAnyPublisher()
    }
    
    func removeFromFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return locale.removeFromFavorite(from: GameMapper.domainsToEntities(input: game)).eraseToAnyPublisher()
    }
    
}
