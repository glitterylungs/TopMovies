import SwiftUI

struct MovieDetailsView: View {
    let movieID: String
    
    @ObservedObject private var viewModel = MovieDetailsViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if let movie = viewModel.movie {
                    AsyncImage(url: URL(string: movie.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250)
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
                                        .background(.gray)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        //
                        if let rating = Float(movie.rating) {
                            
                            ZStack{
                                ZStack {
                                    Circle()
                                        .stroke(
                                            Color.green.opacity(0.5),
                                            lineWidth: 10
                                        )
                                    Circle()
                                    
                                  
                                        .trim(from: 0, to: CGFloat(rating/10))
                                        .stroke(
                                            Color("BackButtonColor"),
                                            style: StrokeStyle(
                                                lineWidth: 10,
                                                lineCap: .round
                                            )
                                        )
                                        .rotationEffect(.degrees(-90))
                                        Text(movie.rating).font(.callout).fontWeight(.bold).padding(.horizontal, 20)
                                }.frame(width: 70)
                            }
                            
                        }
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
