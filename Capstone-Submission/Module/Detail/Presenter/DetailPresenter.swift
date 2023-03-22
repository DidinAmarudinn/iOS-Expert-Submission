//
//  DetailPresenter.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 02/03/23.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    
    @Published var game: GameModel?
    @Published var errorMessage = ""
    @Published var loadingState = false
    @Published var isSuccessAddOrRemove = false
    @Published var isErrorAddOrRemove = false
    @Published var isFavorite = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    
    func getDetailGame(id: Int) {
        loadingState = true
        detailUseCase.getDetailGame(id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.loadingState = false
                case .failure(let error):
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { game in
                self.game = game
                self.isFavorite = game.isFavorite
            }.store(in: &cancellables)
    }
    
    func addToFavorite() {
        if let game = self.game {
            detailUseCase.addToFavorite(game: game).receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                        self.isErrorAddOrRemove = true
                    }
                } receiveValue: { result in
                    self.isFavorite = true
                    self.isSuccessAddOrRemove = result
                    if (!result) {
                        self.isErrorAddOrRemove = true
                    }
                }.store(in: &cancellables)
        }
    }
    
    func removeFromFavorite() {
        if let game = self.game {
            detailUseCase.removeFromFavorite(game: game).receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                        self.isErrorAddOrRemove = true
                    }
                } receiveValue: { result in
                    self.isSuccessAddOrRemove = result
                    self.isFavorite = false
                    if (!result) {
                        self.isErrorAddOrRemove = true
                    }
                }.store(in: &cancellables)
        }
    }
    
    func removeOrAdd() {
        if (isFavorite) {
            removeFromFavorite()
        } else {
            addToFavorite()
        }
    }
    
}
