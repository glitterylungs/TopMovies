//
//  MovieTrailerView.swift
//  TopMovies
//
//  Created by Alicja Gruca on 16/06/2023.
//

import SwiftUI
import YouTubePlayerKit

struct MovieTrailerView: View {
    let movieName: String
    let trailerURL: String
    
    var body: some View {
        VStack {
            Text("\(movieName) Trailer").font(.title).fontWeight(.bold)
            YouTubePlayerView(YouTubePlayer(source: .url(trailerURL))) { state in
                switch state {
                case .idle:
                    ProgressView()
                case .ready:
                    EmptyView()
                case .error(_):
                    Text(verbatim: "YouTube player couldn't be loaded")
                }
            }
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }.padding()
    }
}

struct MovieTrailerView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTrailerView(movieName: "Lala", trailerURL: "https://www.youtube.com/watch?v=qu7b8nzwaPU")
    }
}
