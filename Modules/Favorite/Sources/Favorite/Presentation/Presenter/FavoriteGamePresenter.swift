//
//  File.swift
//  
//
//  Created by didin amarudin on 22/03/23.
//

import Foundation
import Combine
import Core

public class FavoriteGamePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let _favoriteUseCase: GetFavoriteInteractor
    
    
    @Published public var games: [GameDomainModel] = []
    @Published public var errorMessage = ""
    @Published public var loadingState = false
    
    public init(favoriteUseCase: GetFavoriteInteractor) {
        _favoriteUseCase = favoriteUseCase
    }
    
   public func getFavoriteGames() {
        loadingState = true
        _favoriteUseCase.execute(reqest: nil)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.loadingState = false
                case .failure(let error):
                    print(error)
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { games in
                print(games)
                self.games = games
            }.store(in: &cancellables)
    }
}
