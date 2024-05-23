//
//  MoviesView.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 8.05.2024.
//
import SwiftUI

struct HomePageView<Model>: View  where Model: HomePageViewModelProtocol {
    @StateObject var viewModel: Model
    @State var showingNow: Bool = true
    @State private var isSearching = false
    var body: some View {
        GeometryReader { _ in
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        ButtonView(showingNowPlayingMovies: $showingNow)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(showingNow ? viewModel.filteredNowPlaying : viewModel.filteredUpcoming, id: \.id) { item in
                                NavigationLink {
                                    DetailScreenView(viewModel: DetailScreenViewModel(),
                                                     movieID: item.id ?? 238,
                                                     imageURL: "https://image.tmdb.org/t/p/w500\(item.posterPath ?? "")")
                                } label: {
                                    VStack(spacing: 4) {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(item.posterPath ?? "")")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            CircularProgressIndicator()
                                        }
                                        .frame(width: 167, height: 250)
                                        HStack {
                                            HomePageDetailView(movieID: item.id ?? 238)
                                        }
                                        .padding(.top, 8)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 20)
                                        .padding(.leading, 5)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }.toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                    Text("Movie")
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                    }
                }
                .background(Color("AdaptiveBgColor"))
            }
            .searchable(text: $viewModel.searchText, isPresented: $isSearching)
        }
        .task {
            await viewModel.getNowPlayingMovies()
            await viewModel.getUpcomingMovies()
        }
    }
}

#Preview {
    HomePageView(viewModel: HomePageViewModel(), showingNow: true)
}
