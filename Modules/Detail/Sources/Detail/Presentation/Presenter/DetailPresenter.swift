//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Combine
import Core

public class DetailGamePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    private let _detailUseCase: GetDetailInteractor
    private let _addToFavUseCase: AddToFavoriteInteractor
    private let _removeFromFavUseCase: RemoveFromFavoriteInteractor
    
    @Published public var game: GameDomainModel?
    @Published public var errorMessage = ""
    @Published public var loadingState = false
    @Published public var isSuccessAddOrRemove = false
    @Published public var isErrorAddOrRemove = false
    @Published public var isFavorite = false
    
    public init(detailUseCase: GetDetailInteractor, addToFavUseCase: AddToFavoriteInteractor, removeFromFavUseCase: RemoveFromFavoriteInteractor) {
        _detailUseCase = detailUseCase
        _addToFavUseCase = addToFavUseCase
        _removeFromFavUseCase = removeFromFavUseCase
    }
    
    public func getDetailGame(id: Int) {
        loadingState = true
        _detailUseCase.execute(reqest: id)
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
            _addToFavUseCase.execute(reqest: game).receive(on: RunLoop.main)
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
            _removeFromFavUseCase.execute(reqest: game).receive(on: RunLoop.main)
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
    
    public func removeOrAdd() {
        if (isFavorite) {
            removeFromFavorite()
        } else {
            addToFavorite()
        }
    }
}
