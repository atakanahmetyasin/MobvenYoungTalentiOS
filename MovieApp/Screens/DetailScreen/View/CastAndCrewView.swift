import SwiftUI

struct CastAndCrewView: View {
    @State var movieID: Int
    @StateObject private var viewModel = CastAndCrewViewModel()
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Cast & Crew")
                        .font(.system(size: 18))
                        .foregroundStyle(Color("AdaptiveColor"))
                    Spacer()
                    NavigationLink("View All") {
                        AllCastAndCrewView(viewModel: CastAndCrewViewModel(), movieID: movieID)
                    }
                    .foregroundStyle(Color(red: 71/255, green: 207/255, blue: 255/255, opacity: 1))
                    .font(.system(size: 14))
                }
                .padding(.horizontal, 8)
                ForEach(viewModel.resultMovieCast.prefix(6), id: \.id) { item in
                    HStack(spacing: 16) {
                        let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.profilePath ?? "")")
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        } placeholder: {
                            CircularProgressIndicator()
                        }
                        .frame(width: 50, height: 50)
                        Text(item.originalName ?? "")
                            .fontWeight(.bold)
                            .frame(width: 120, alignment: .leading)
                            .foregroundStyle(Color("AdaptiveColor"))
                        Spacer()
                        NavigationLink("...") {
                        }
                        .foregroundStyle(Color("AdaptiveColor").opacity(0.3))
                        .font(.title)
                        .offset(y: -8)
                        Spacer()
                        Text(item.character ?? "")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textCase(.uppercase)
                            .foregroundStyle(Color("AdaptiveColor").opacity(0.5))
                            .font(.system(size: 12))
                    }
                    .padding(.horizontal, 8)
                }
            }.task {
                await viewModel.getCastAndCrew(movieID: movieID)
            }
        }
    }
}

#Preview {
    CastAndCrewView(movieID: 238)
}
