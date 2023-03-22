//
//  FavoriteInteractor.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import Foundation
import Combine
protocol FavoriteUseCase {
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: CapstoneRepositoryProtocol
    
    required init(repository: CapstoneRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getListFavoriteGame()
    }
}
