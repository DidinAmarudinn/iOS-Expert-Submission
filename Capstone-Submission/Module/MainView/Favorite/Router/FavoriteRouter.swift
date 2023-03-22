//
//  FavoriteRouter.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 05/03/23.
//

import Foundation
import SwiftUI
import Detail
class FavoriteRouter {
    func makeDetailView(for id: Int) -> some View {
      let presenter = DetailGamePresenter(detailUseCase: getDetailUseCase, addToFavUseCase: addToFavUseCase, removeFromFavUseCase: removeFromFavUseCase)
      return DetailView(id: id, presenter: presenter)
    }
    
}
