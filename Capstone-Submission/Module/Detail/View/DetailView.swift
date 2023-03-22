//
//  DetailView.swift
//  Capstone-Submission
//
//  Created by didin amarudin on 02/03/23.
//

import SwiftUI
import AlertToast
import Kingfisher
import Core
import Detail
struct DetailView: View {
    @ObservedObject var presenter: DetailGamePresenter
    @Environment(\.presentationMode) var mode
    let id: Int
    init(id: Int, presenter: DetailGamePresenter) {
        self.id = id
        self.presenter = presenter
    }
    var body: some View {
        VStack {
            if (presenter.loadingState) {
                Text("Loading...")
                ProgressView()
            } else {
                headerView
                gameContent
                Spacer()
            }
            
        }.onAppear {
            if (presenter.game == nil) {
                presenter.getDetailGame(id: id)
            }
        }.navigationBarBackButtonHidden()
    }
}

extension DetailView {
    var headerView: some View {
        ZStack(alignment: .topLeading) {
            KFImage(URL(string: presenter.game?.backgroundImage ?? ""))
                .resizable()
                .frame(height: 250)
                .scaledToFit()
            
            LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black.opacity(0.1) ,  .black.opacity(0.2) , .black.opacity(0.4),]), startPoint: .top, endPoint: .bottom)
            
            VStack {
                HStack {
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                            Text("Back")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        .frame(height: 44)
                        .background(Color.red)
                        .cornerRadius(22)
                    }
                    
                    Spacer()
                    
                    Button {
                        presenter.removeOrAdd()
                    } label: {
                        if (presenter.isFavorite) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(.red)
                        }
                    }
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(presenter.game?.name ?? "")
                            .foregroundColor(.white)
                            .font(.headline)
                        Text("(\((presenter.game?.rating ?? 0).toRating()))")
                            .font(.caption)
                        Spacer()
                    }
                    Text(presenter.game?.released ?? "")
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            .padding(.top, 50)
        }
        .frame(height: 250)
        .ignoresSafeArea()
    }
}


extension DetailView {
    var gameContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Genres")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach( self.presenter.game?.genres ?? [] ) { genres in
                            Text(genres.name)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical,4)
                                .background(Color.red.opacity(0.2))
                                .cornerRadius(2)
                        }
                    }
                }
                Text("Description")
                Text(presenter.game?.gameDesc ?? "")
                    .font(.caption)
                    .lineSpacing(3)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach( self.presenter.game?.tags ?? [] ) { tags in
                            Text("#\(tags.name)")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical,4)
                                .background(Color.red.opacity(0.2))
                                .cornerRadius(2)
                        }
                    }
                }
            }
        }.padding(.horizontal)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 0, presenter: DetailGamePresenter(detailUseCase: getDetailUseCase, addToFavUseCase: addToFavUseCase, removeFromFavUseCase: removeFromFavUseCase))
    }
}
