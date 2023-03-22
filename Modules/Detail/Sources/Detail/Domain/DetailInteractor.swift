//
//  File.swift
//  
//
//  Created by didin amarudin on 19/03/23.
//

import Foundation
import Core

public typealias GetDetailInteractor = Interactor<Int, GameDomainModel, DetailRepository<DetailGameLocalDataSource, DetailGameRemoteDataSource, DetailGameTransformer>>


public typealias AddToFavoriteInteractor = Interactor<GameDomainModel, Bool, AddToFavoriteRepository<DetailGameLocalDataSource, DetailGameTransformer>>


public typealias RemoveFromFavoriteInteractor = Interactor<GameDomainModel, Bool, RemoveFromFavoriteRepository<DetailGameLocalDataSource, DetailGameTransformer>>
