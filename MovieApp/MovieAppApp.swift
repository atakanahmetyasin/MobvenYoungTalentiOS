import SwiftUI

@main
struct MovieAppApp: App {
    @StateObject var dataViewModel = SwiftDataViewModel()
    var body: some Scene {
        WindowGroup {
           SplashScreenView()
                .environmentObject(dataViewModel)
        }
    }
}
