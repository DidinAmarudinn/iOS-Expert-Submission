//
//  HomeRouter.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 01/03/23.
//

import Foundation
import SwiftUI
import Detail
class HomeRouter {
    func makeDetailView(for id: Int) -> some View {
      let presenter = DetailGamePresenter(detailUseCase: getDetailUseCase, addToFavUseCase: addToFavUseCase, removeFromFavUseCase: removeFromFavUseCase)
      return DetailView(id: id, presenter: presenter)
    }
    
}
