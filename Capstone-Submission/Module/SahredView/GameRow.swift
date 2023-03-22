//
//  GameRow.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 01/03/23.
//

import SwiftUI
import Kingfisher
import Core

struct GameRow: View {
    var game: GameDomainModel
    var body: some View {
        HStack(alignment: .top) {
            KFImage(URL(string: game.backgroundImage))
                .resizable()
                .frame(width: 150, height: 100)
                .scaledToFit()
                .cornerRadius(12)
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.title3)
                Spacer()
                Text(game.released)
                    .font(.subheadline)
                Spacer()
                Text("\(game.rating.toRating())")
                    .font(.caption)
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        
    }
}

