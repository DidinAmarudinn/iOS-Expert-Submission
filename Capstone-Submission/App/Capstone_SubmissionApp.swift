//
//  Capstone_SubmissionApp.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import SwiftUI
import Games
import Core
import Detail
import Favorite
let getGamesUseCase: Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesRemoteDataSource, GamesTransformer>> = Injection.init().provideGames()
let getDetailUseCase: Interactor<Int, GameDomainModel, DetailRepository<DetailGameLocalDataSource, DetailGameRemoteDataSource, DetailGameTransformer>> = Injection.init().provideDetail()
let addToFavUseCase: Interactor<GameDomainModel, Bool, AddToFavoriteRepository<DetailGameLocalDataSource, DetailGameTransformer>> = Injection.init().addToFav()
let getFavoriteUseCase: Interactor<Any, [GameDomainModel], FavoriteRepository<FavoriteLocalDataSource, FavoriteTransformer>> = Injection.init().getFavorite()
let removeFromFavUseCase: Interactor<GameDomainModel, Bool, RemoveFromFavoriteRepository<DetailGameLocalDataSource, DetailGameTransformer>> = Injection.init().removeFromFav()
@main
struct Capstone_SubmissionApp: App {
    let homePresenter = GetListPersenter(useCase: getGamesUseCase)
    let favoritePresenter = FavoriteGamePresenter(favoriteUseCase: getFavoriteUseCase)
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
                .preferredColorScheme(.dark)
        }
    }
}
