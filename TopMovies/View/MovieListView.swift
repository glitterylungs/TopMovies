//
//  ContentView.swift
//  TopMovies
//
//  Created by Alicja Gruca on 07/06/2023.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject private var viewModel = MovieListViewModel()
    
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
                            Text(String(movie.rank))
                            AsyncImage(url: URL(string: movie.thumbnail))
                            Text(movie.title)
                        }
                    }
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
