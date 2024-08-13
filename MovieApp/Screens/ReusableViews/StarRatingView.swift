//
//  StarRatingView.swift
//  MovieApp
//
//  Created by Ahmet Yasin Atakan on 12.08.2024.
//

import SwiftUI
struct StarRatingView: View {
    let roundedVote: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= roundedVote ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .frame(width: 14, height: 14)
            }
        }
    }
}
