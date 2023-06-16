import Foundation
import Alamofire

class MovieListViewModel: ObservableObject {
    
    private let movieService = MovieService()
    
    @Published var movies: [Movie] = []

    func fetchMovies() {
        movieService.getMovies { [weak self] movies in
            DispatchQueue.main.async {
                self?.movies = movies?.shuffled() ?? []
            }
        }
    }
    
    func filteredMovies(for searchText: String) -> [Movie] {
        guard !searchText.isEmpty else {return movies}
        return movies.filter { movie in
            movie.title.localizedCaseInsensitiveContains(searchText)
        }
    }

}
