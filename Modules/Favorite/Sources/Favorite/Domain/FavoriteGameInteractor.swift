//
//  File.swift
//  
//
//  Created by didin amarudin on 22/03/23.
//

import Foundation
import Core
public typealias GetFavoriteInteractor = Interactor<Any, [GameDomainModel], FavoriteRepository<FavoriteLocalDataSource, FavoriteTransformer>>
