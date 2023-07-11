//
//  MovieDetailsView.swift
//  TopMovies
//
//  Created by Alicja Gruca on 11/06/2023.
//

import SwiftUI

struct MovieDetailsView: View {
    let movieID: String
    
    @ObservedObject private var viewModel = MovieDetailsViewModel()
    
    @State private var isShowingTrailer = false
    
    var body: some View {
        ScrollView {
            VStack {
                if let movie = viewModel.movie {
                    Button(action: { isShowingTrailer = true }) {
                        ZStack {
                            AsyncImage(url: URL(string: movie.image)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 250)
                            
                            Image(systemName: "play.circle").font(.system(size: 80)).opacity(0.5)
                        }
                    }
                    .sheet(isPresented: $isShowingTrailer) {
                        MovieTrailerView(movieName: movie.title, trailerURL: movie.trailer)
                            .presentationDetents([.fraction(0.6)])
                    }
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.medium)
                    Text("by \(movie.director.joined(separator: ", "))")
                    Spacer(minLength: 15)
                    Text(String(movie.year)).font(.callout).fontWeight(.medium)
                    Spacer(minLength: 20)
                    HStack{
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 10) {
                                ForEach(movie.genre, id: \.self) { genre in
                                    Text(genre)
                                        .padding(10)
                                        .background(Color("GenreColor"))
                                        .cornerRadius(20)
                                }
                            }
                        }
                        Text(movie.rating).font(.largeTitle).fontWeight(.bold).padding(.horizontal, 20)
                    }
                    Spacer(minLength: 30)
                    VStack(alignment: .leading){
                        Text(movie.description).font(.body)
                    }
                    Spacer()
                } else {
                    ProgressView("Loading...")
                }
            }
            .padding(.horizontal, 20)
            .onAppear {
                viewModel.fetchMovieDetails(id: movieID)
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieID: "top17")
    }
}
