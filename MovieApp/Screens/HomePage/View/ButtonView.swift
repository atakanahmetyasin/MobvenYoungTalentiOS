import SwiftUI

protocol ButtonViewProtocol: AnyObject {
    var showingNowPlayingMovies: Bool { get }
}

struct ButtonView: View {
    @Binding var showingNowPlayingMovies: Bool
    @StateObject var viewModel = HomePageViewModel()
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Button {
                    showingNowPlayingMovies = true
                } label: {
                    Image(systemName: "play.circle.fill")
                    Text("Now Showing")
                }
                .foregroundStyle(showingNowPlayingMovies ? .red : Color("AdaptiveColor"))
                .frame(width: geometry.size.width / 2.2, height: 34)
                .cornerRadius(17)
                Button {
                    showingNowPlayingMovies = false
                } label: {
                    Image(systemName: "play.circle.fill")
                    Text("Coming Soon")
                }
                .foregroundStyle(!showingNowPlayingMovies ? .red : Color("AdaptiveColor"))
                .frame(width: geometry.size.width / 2.2, height: 34)
                .cornerRadius(17)
            }
            .fontWeight(.bold)
            //            .padding(.horizontal, 16)
        }
    }
}
