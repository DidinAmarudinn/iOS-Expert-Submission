//
//  DetailInteractor.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import Foundation
import Combine
protocol DetailUseCase {
    func getDetailGame(id: Int) -> AnyPublisher<GameModel, Error>
    func addToFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
    func removeFromFavorite(game: GameModel) -> AnyPublisher<Bool, Error>
}


class DetailInteractor: DetailUseCase {
    private let repository: CapstoneRepositoryProtocol
    
    required init(repository: CapstoneRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetailGame(id: Int) -> AnyPublisher<GameModel, Error> {
        return repository.getDetailGame(id: id)
    }
    
    func addToFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.addToFavorite(game: game)
    }
    
    func removeFromFavorite(game: GameModel) -> AnyPublisher<Bool, Error> {
        return repository.removeFromFavorite(game: game)
    }
}
