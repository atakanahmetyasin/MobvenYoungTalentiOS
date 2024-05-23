//
//  HomePageDetailView.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 10.05.2024.
//
import SwiftUI

struct HomePageDetailView: View {
    @State var movieID: Int
    @StateObject var viewModel = DetailScreenViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let voteAverage = viewModel.detailResult?.voteAverage {
                    let roundedVote = Int(round(voteAverage / 2))
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= roundedVote ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .frame(width: 14, height: 14)
                    }
                    .padding(.top, 16)
                    .frame(width: 14, alignment: .leading)
                }
            }
            Text(viewModel.detailResult?.originalTitle ?? "")
                .font(.custom("SF-Pro-Text", size: 16))
                .fontWeight(.medium)
                .foregroundStyle(Color("AdaptiveColor"))
                .frame(height: 40)
                .multilineTextAlignment(.leading)
            HStack(spacing: 4) {
                Text(viewModel.detailResult?.genres?.first?.name ?? "")
                Text("·")
                    .fontWeight(.bold)
                    .font(.system(size: 12))
                Text(String((viewModel.detailResult?.runtime ?? 0) / 60) + "h")
                Text(String((viewModel.detailResult?.runtime ?? 0) % 60) + "m")
                Text("|")
                ReleaseDatesView(viewModel: ReleaseDatesViewModel(), movieID: movieID)
            }
            .foregroundStyle(Color("AdaptiveColor").opacity(0.5))
            .font(.custom("SF-Pro-Text", size: 12))
        }.task {
            await viewModel.getMoviesDetail(movieID: movieID)
        }
    }
}

#Preview {
    HomePageDetailView(movieID: 424)
}
