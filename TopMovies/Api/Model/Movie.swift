import Foundation


struct Movie: Codable {
    let rank: Int
    let title: String
    let thumbnail: String
    let rating: String
    let id: String
    let year: Int
    let image: String
    let description: String
    let trailer: String
    let genre: [String]
    let director: [String]
    let writers: [String]
    let imdbid: String
}
