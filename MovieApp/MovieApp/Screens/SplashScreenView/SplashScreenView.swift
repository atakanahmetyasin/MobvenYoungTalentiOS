import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    var body: some View {
        if self.isActive {
            TabBarView()
                .transition(.asymmetric(insertion: .opacity, removal: .scale))
        } else {
            ZStack {
                Color.red.ignoresSafeArea(edges: .all)
                Image("splash")
                    .resizable()
                    .frame(width: 108, height: 184)
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
