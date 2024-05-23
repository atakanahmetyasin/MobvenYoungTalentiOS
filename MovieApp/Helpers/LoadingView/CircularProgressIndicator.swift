import SwiftUI

struct CircularProgressIndicator: View {
    @State private var isDataLoaded = false
    var body: some View {
        GeometryReader { _ in
            if !isDataLoaded {
                ProgressView()
                    .frame(width: 50, height: 50)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            } else {
                Image("noimage")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                isDataLoaded = true
            }
        }
    }
}

#Preview {
    CircularProgressIndicator()
}
