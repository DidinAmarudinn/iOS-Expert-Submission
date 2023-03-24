//
//  HomeView.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 01/03/23.
//

import SwiftUI
import Combine
import Games
import Core
import Detail
struct HomeView: View {
    @ObservedObject var presenter: GetListPersenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesRemoteDataSource, GamesTransformer>>>
    var body: some View {
        ZStack {
            if presenter.isLoading {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        Text("Capstone Games")
                            .font(.title)
                            .padding(16)
                        ForEach( self.presenter.list ) { game in
                            NavigationLink(destination: DetailView(id: game.id, presenter: DetailGamePresenter(detailUseCase: getDetailUseCase, addToFavUseCase: addToFavUseCase, removeFromFavUseCase: removeFromFavUseCase))) {
                                GameRow(game: game)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }
    }
}

