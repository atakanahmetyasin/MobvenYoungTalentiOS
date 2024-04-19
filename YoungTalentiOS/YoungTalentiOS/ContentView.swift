//
//  ContentView.swift
//  YoungTalentiOS
//
//  Created by Ahmet Yasin Atakan on 19.04.2024.
//

import SwiftUI

struct ContentView: View {
    let mainUrl = Bundle.main.infoDictionary?["BACKEND_URL"] as? String
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(mainUrl ?? "")
                .font(.title)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
