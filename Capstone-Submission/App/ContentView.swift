//
//  ContentView.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import SwiftUI
import Combine
import Core
import Games

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPersenter<Any, GameDomainModel, Interactor<Any, [GameDomainModel], GetGamesRepository<GetGamesRemoteDataSource, GamesTransformer>>>
    var body: some View {
        NavigationStack {
            MainView(homePresenter: _homePresenter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
