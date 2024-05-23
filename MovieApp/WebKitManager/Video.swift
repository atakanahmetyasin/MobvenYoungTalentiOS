//
//  Video.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 13.05.2024.
//

import SwiftUI
import WebKit

struct Video: UIViewRepresentable {
    let videoID: String
    func makeUIView(context: Context) -> some WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let youTubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youTubeURL))
    }
}

// #Preview {
//    Video()
// }
