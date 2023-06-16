import Foundation
import Alamofire

class MovieService {
    let baseUrlString = Constants.baseUrl
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": Constants.apiKey,
            "X-RapidAPI-Host": Constants.apiHost
        ]

        func getMovies(completion: @escaping ([Movie]?) -> Void) {
            AF.request(baseUrlString, headers: headers).responseDecodable(of: [Movie].self) { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let movies = try JSONDecoder().decode([Movie].self, from: data)
                            completion(movies)
                        } catch {
                            print("Error decoding movies: \(error.localizedDescription)")
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }

    func getMovie(movieID: String, completion: @escaping (Movie?) -> Void) {
        let singleMovieURLString = "\(baseUrlString)\(movieID)"
        AF.request(singleMovieURLString, headers: headers).responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let movie = try JSONDecoder().decode(Movie.self, from: data)
                        completion(movie)
                    } catch {
                        print("Error decoding movie: \(error.localizedDescription)")
                        completion(nil)
                    }
                } else {
                    completion(nil) // Empty data response
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
