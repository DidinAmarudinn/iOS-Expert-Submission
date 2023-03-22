//
//  HomeInteractor.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getGames() -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {
    private let repository: CapstoneRepositoryProtocol
    
    required init(repository: CapstoneRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getGames()
    }
}
