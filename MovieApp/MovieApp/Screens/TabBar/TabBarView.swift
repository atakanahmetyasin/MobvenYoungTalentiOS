import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
                HomePageView(viewModel: HomePageViewModel())
                    .tabItem {
                        Image("movie")
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                    }
            TicketView()
                .tabItem {
                    Image("ticket")
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                }
                WatchListView()
                    .tabItem {
                        Image("bookmark")
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                    }
           ProfileView()
                .tabItem {
                    Image("profile")
                        .renderingMode(.template)
                        .frame(width: 24, height: 24)
                }
        }
        .accentColor(Color(red: 71/255, green: 207/255, blue: 255/255, opacity: 1))
    }
}

#Preview {
    TabBarView()
        .environmentObject(SwiftDataViewModel())
}
