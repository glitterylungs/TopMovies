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
        VStack {
            List(viewModel.movies, id: \.id) { movie in
                HStack{
                    Text(String(movie.rank))
                    AsyncImage(url: URL(string: movie.thumbnail))
                    Text(movie.title)
                }
                        
                    }
                    .onAppear {
                        viewModel.fetchMovies()
                    }
                    .listStyle(.inset)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
