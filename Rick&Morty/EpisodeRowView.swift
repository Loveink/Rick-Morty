//
//  EpisodeRowView.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 21.08.2023.
//

import SwiftUI

struct EpisodeRowView: View {
    let episode: Episode

    var body: some View {
        HStack {
            Rectangle()
                .foregroundColor(Color(red: 0.15, green: 0.16, blue: 0.22))
                .frame(width: 370, height: 100)
                .cornerRadius(10)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text(episode.name)
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.bottom, 4)
                            HStack {
                                Text(episode.episode)
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                                Spacer()
                                Text(episode.airDate)
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.leading)
                        Spacer()
                    }
                )
        }
    }
}
