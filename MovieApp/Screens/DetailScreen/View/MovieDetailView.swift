import SwiftUI

struct MovieDetailView: View {
    @State var movieID: Int
    @StateObject var viewModel = DetailScreenViewModel()
    @State var synopsisExpand: Bool = false
    var body: some View {
        VStack(spacing: 14) {
            Text(viewModel.detailResult?.originalTitle ?? "l")
                .fontWeight(.medium)
                .font(.system(size: 24))
                .foregroundStyle(Color("AdaptiveColor"))
            HStack {
                Text(String((viewModel.detailResult?.runtime ?? 0) / 60) + "h")
                Text(String((viewModel.detailResult?.runtime ?? 0) % 60) + "m")
                Text("|")
                ReleaseDatesView(viewModel: ReleaseDatesViewModel(), movieID: movieID)
            }
            .foregroundStyle(Color("AdaptiveColor").opacity(0.5))
            HStack {
                ForEach(viewModel.detailResult?.genres ?? [], id: \.id) { genre in
                    Text(genre.name ?? "")
                }
                .foregroundStyle(Color("AdaptiveColor").opacity(0.55))
            }
            HStack {
                if let voteAverage = viewModel.detailResult?.voteAverage {
                    let roundedVote = Int(round(voteAverage / 2))
                    Text(String(format: "%.1f/5", voteAverage / 2))
                        .font(.system(size: 30))
                        .foregroundColor(Color("AdaptiveColor"))
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= roundedVote ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                    }
                }
            }
            Text("Synopsis")
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
                .foregroundStyle(Color("AdaptiveColor"))
            Text(viewModel.detailResult?.overview ?? "")
                .frame(maxHeight: synopsisExpand ? .infinity : 105)
                .padding(.horizontal, 8)
                .foregroundStyle(Color("AdaptiveColor").opacity(0.7))
            Button(action: {
                synopsisExpand.toggle()
            }, label: {
                Text(synopsisExpand ? "Show Less" : "Show More")
                    .foregroundStyle(.blue)
            })
            .foregroundStyle(.blue)
        }
        .task {
            await viewModel.getMoviesDetail(movieID: movieID)
        }
    }
}

#Preview {
        MovieDetailView(movieID: 608)
}
