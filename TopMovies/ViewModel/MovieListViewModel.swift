//
//  MovieListViewModel.swift
//  TopMovies
//
//  Created by Alicja Gruca on 11/06/2023.
//

import Foundation
import Alamofire

class MovieListViewModel: ObservableObject {
    
    private let movieService = MovieService()
    
    @Published var movies: [Movie] = []

    func fetchMovies() {
        movieService.getMovies { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies?.reversed() ?? []
            }
        }
    }
}
