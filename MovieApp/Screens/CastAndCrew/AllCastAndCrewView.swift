import SwiftUI

struct AllCastAndCrewView<Model>: View  where Model: CastAndCrewViewModelProtocol {
    @StateObject var viewModel: Model
    @State var movieID: Int
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    Color.gray.opacity(0.1)
                        .frame(width: UIScreen.main.bounds.width, height: 2)
                    ForEach(viewModel.resultMovieCast, id: \.id) { item in
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(item.profilePath ?? "")")) { image in
                                image
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                            } placeholder: {
                                CircularProgressIndicator()
                            }
                            .frame(width: 50, height: 50)
                            Text(item.originalName ?? "")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("AdaptiveColor"))
                            Spacer()
                            NavigationLink("...") {
                                Text(item.name ?? "")
                            }
                            .foregroundStyle(Color("AdaptiveColor").opacity(0.3))
                            .font(.title)
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
            .padding(.top, -50)
            .background(Color("AdaptiveBgColor"))
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Text("Cast & Crew")
                                    .padding(.leading, 100)
                            }
                        }
            .customBackButton()
        }
    }
}

#Preview {
    AllCastAndCrewView(viewModel: CastAndCrewViewModel(), movieID: 238)
}
