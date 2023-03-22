//
//  FavoriteView.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 04/03/23.
//

import SwiftUI
import Favorite
import Detail
struct FavoriteView: View {
    @ObservedObject var presenter: FavoriteGamePresenter
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading) {
                        Text("Your Favorite Games")
                            .font(.title)
                            .padding(16)
                        ForEach( self.presenter.games ) { game in
                           NavigationLink(destination: DetailView(id: game.id, presenter: DetailGamePresenter(detailUseCase: getDetailUseCase, addToFavUseCase: addToFavUseCase, removeFromFavUseCase: removeFromFavUseCase))) {
                            GameRow(game: game)
                           }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }.onAppear {
            self.presenter.getFavoriteGames()
        }
    }
}


