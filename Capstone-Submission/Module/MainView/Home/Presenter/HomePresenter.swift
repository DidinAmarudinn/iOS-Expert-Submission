//
//  HomePresenter.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 01/03/23.
//

import Foundation
import Combine
import SwiftUI

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let route = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage = ""
    @Published var loadingState = false
    
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGames() {
        loadingState = true
        homeUseCase.getGames()
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
