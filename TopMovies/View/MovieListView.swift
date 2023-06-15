//
//  ContentView.swift
//  TopMovies
//
//  Created by Alicja Gruca on 07/06/2023.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject private var viewModel = MovieListViewModel()
    
    @State private var randomMovieID: String? = nil
        @State private var shouldNavigate = false
    
    var body: some View {
        NavigationView {
            if viewModel.movies.isEmpty {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.fetchMovies()
                    }
            } else {
                List(viewModel.movies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailsView(movieID: movie.id)) {
                        HStack {
                            Text(String(movie.rank)).font(.headline).fontWeight(.medium)
                            AsyncImage(url: URL(string: movie.thumbnail)){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                ProgressView()
                            }.frame(width: 50).padding(.horizontal, 10)
                            Text(movie.title)
                        }
                    }.onShake {
                        guard !shouldNavigate else { return }
                        randomMovieID = "top\(Int.random(in: 1...100))"
                        shouldNavigate = true
                    }
                    .background(
                        NavigationLink(
                            destination: MovieDetailsView(movieID: randomMovieID ?? ""),
                            isActive: $shouldNavigate,
                            label: { EmptyView() }
                        )
                        .hidden()
                    )
                }
                .navigationTitle("Top 100 Movies")
                .listStyle(.inset)

            }
        }.accentColor(Color("Text"))
    }
}

extension String: Identifiable {
    public var id: String { return self }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
