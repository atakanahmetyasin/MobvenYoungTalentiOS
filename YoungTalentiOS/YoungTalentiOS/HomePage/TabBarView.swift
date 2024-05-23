//
//  TabView.swift
//  YoungTalentiOS
//
//  Created by Ahmet Yasin Atakan on 8.05.2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Text("First Tab")
                .tabItem {
                    Label("First", systemImage: "1.square.fill")
                }
        }
    }
}

#Preview {
    TabBarView()
}
