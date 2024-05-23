import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var current
    @AppStorage("colorScheme") private var colorScheme = 0
    var body: some View {
        NavigationStack {
            ZStack {
                Color("AdaptiveBgColor").ignoresSafeArea()
                Picker("", selection: $colorScheme) {
                    Text("Light").tag(0)
                    Text("Dark").tag(1)
                }
                .pickerStyle(.segmented)
            }
        }
        .preferredColorScheme(colorScheme == 0 ? .light : .dark)
    }
}

#Preview {
    ProfileView()
}
