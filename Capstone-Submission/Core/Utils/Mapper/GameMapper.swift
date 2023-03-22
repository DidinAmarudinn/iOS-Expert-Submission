//
//  GameMapper.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 26/02/23.
//

import Foundation

final class GameMapper {
    static func mapGamesResponseToDomains(input gamesResponses: [GameResponse]) -> [GameModel] {
        return gamesResponses.map { result in
            var genres: [AdditionDataModel] = []
            if let genresData = result.genres {
                for genre in genresData {
                    let genre = AdditionDataModel(id: genre.id ?? 0, name: genre.name ?? "",
                                                  slug: genre.slug ?? "", gamesCount: genre.gamesCount ?? 0,
                                                  imageBackground: genre.imageBackground ?? "")
                    genres.append(genre)
                }
            }
            let games = GameModel(id: result.id ?? 0,
                                  slug: result.slug ?? "",
                                  name: result.name ?? "",
                                  released: result.released ?? "",
                                  tba: result.tba ?? false,
                                  backgroundImage: result.backgroundImage ?? "",
                                  rating: result.rating ?? 0.0,
                                  ratingTop: result.ratingTop ?? 0,
                                  genres: genres,
                                  gameDesc: "",
                                  isFavorite: false,
                                  tags: [])
            return games
        }
    }
    
    static func detailGameResponseToDomains(input detailGameResponse: DetailGameResponse, isFavorite: Bool) -> GameModel {
        var genres: [AdditionDataModel] = []
        if let genresData = detailGameResponse.genres {
            for genre in genresData {
                let genre = AdditionDataModel(id: genre.id ?? 0, name: genre.name ?? "",
                                              slug: genre.slug ?? "", gamesCount: genre.gamesCount ?? 0,
                                              imageBackground: genre.imageBackground ?? "")
                genres.append(genre)
            }
        }
        var tags: [AdditionDataModel] = []
        if let tagsData = detailGameResponse.tags {
            for tag in tagsData {
                let genre = AdditionDataModel(id: tag.id ?? 0, name: tag.name ?? "",
                                              slug: tag.slug ?? "", gamesCount: tag.gamesCount ?? 0,
                                              imageBackground: tag.imageBackground ?? "")
                tags.append(genre)
            }
        }
        let game = GameModel(id: detailGameResponse.id ?? 0,
                             slug: detailGameResponse.slug ?? "",
                             name: detailGameResponse.name ?? "",
                             released: detailGameResponse.released ?? "",
                             tba: detailGameResponse.tba ?? false,
                             backgroundImage: detailGameResponse.backgroundImage ?? "",
                             rating: detailGameResponse.rating ?? 0,
                             ratingTop: detailGameResponse.ratingTop ?? 0,
                             genres: genres,
                             gameDesc: detailGameResponse.descriptionRaw ?? "",
                             isFavorite: isFavorite,
                             tags: tags)
        return game
    }
    
    
    static func mapEntitisToDomains(inpit gameEntitis: [GameEntity]) -> [GameModel] {
        return gameEntitis.map { result in
            return GameModel(id: result.id,
                             slug: "", name: result.name,
                             released: result.released,
                             tba: false,
                             backgroundImage: result.backgroundImage,
                             rating: result.rating,
                             ratingTop: 0,
                             genres: [],
                             gameDesc: "",
                             isFavorite: false,
                             tags: [])
        }
    }
    
    static func domainsToEntities(input gameModel: GameModel) -> GameEntity {
        let entity = GameEntity()
        entity.id = gameModel.id
        entity.name = gameModel.name
        entity.rating = gameModel.rating
        entity.backgroundImage = gameModel.backgroundImage
        entity.released = gameModel.released
        return entity
    }
}
