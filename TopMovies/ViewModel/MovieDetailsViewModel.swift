//
//  MovieDetailsViewModel.swift
//  TopMovies
//
//  Created by Alicja Gruca on 11/06/2023.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    private let movieService = MovieService()
    
    @Published var movie: Movie? = nil
    
    func fetchMovieDetails(id: String) {
        MovieService().getMovie(movieID: id) { movie in
            DispatchQueue.main.async {
                self.movie = movie
            }
        }
    }
}
