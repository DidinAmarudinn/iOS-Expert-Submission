//
//  Injection.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 20/02/23.
//

import Foundation
import RealmSwift
import Core
import Games
import Detail
import Favorite
final class Injection: NSObject {
    let realm = try? Realm()
    func provideGames<U: UseCase>() -> U where U.Request == Any, U.Response == [GameDomainModel] {
        let remote = GetGamesRemoteDataSource()
        let mapper = GamesTransformer()
        
        let repository = GetGamesRepository(remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    func provideDetail<U: UseCase>() -> U where U.Request == Int, U.Response == GameDomainModel {
        let remote = DetailGameRemoteDataSource()
        let locale = DetailGameLocalDataSource(realm: realm!)
        let mapper = DetailGameTransformer()
        
        let repositroy = DetailRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repositroy) as! U
    }
    
    func addToFav<U: UseCase>() -> U where U.Request == GameDomainModel, U.Response == Bool {
        let locale = DetailGameLocalDataSource(realm: realm!)
        let mapper = DetailGameTransformer()
        
        let repositroy = AddToFavoriteRepository(localeDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repositroy) as! U
    }
    
    func removeFromFav<U: UseCase>() -> U where U.Request == GameDomainModel, U.Response == Bool {
        let locale = DetailGameLocalDataSource(realm: realm!)
        let mapper = DetailGameTransformer()
        
        let repositroy = RemoveFromFavoriteRepository(localeDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repositroy) as! U
    }
    
    func getFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [GameDomainModel] {
        let locale = FavoriteLocalDataSource(realm: realm!)
        let mapper = FavoriteTransformer()
        
        let repository = FavoriteRepository(localeDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    
    
    func provideRepository() -> CapstoneRepository {
        let realm = try? Realm()
        let locale = LocaleDataSource.sharedInstance(realm)
        let remote = RemoteDataSource.sharedInstance
        
        return CapstoneRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func providerFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func provideDetailGame() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
}
