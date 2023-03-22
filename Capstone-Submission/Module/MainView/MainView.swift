//
//  MainView.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 04/03/23.
//

import SwiftUI
import Core
import Games
import Favorite
struct MainView: View {
    @EnvironmentObject var homePresenter:  GetListPersenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesRemoteDataSource, GamesTransformer>>>
    @EnvironmentObject var favoritePresenter: FavoriteGamePresenter
    var body: some View {
        TabView {
            HomeView(presenter: homePresenter)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
            AboutView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("About")
                }
        }.background(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
