//
//  FavoritePresenter.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 04/03/23.
//

import Foundation
import Combine
import SwiftUI
class FavoritePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let favoriteUseCase: FavoriteUseCase
    private let route = HomeRouter()
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    @Published var games: [GameModel] = []
    @Published var errorMessage = ""
    @Published var loadingState = false
    
    func getFavoriteGames() {
        loadingState = true
        favoriteUseCase.getFavoriteGames()
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
    
    func linkBuilder<Content: View>(
        for id: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: route.makeDetailView(for: id)){ content() }
    }
}
