//
//  CharacterDetailViewController.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 21.08.2023.
//

import SwiftUI

struct CharacterDetailView: View {
  var character: Result
  @State private var locationInfo: LocationInfo? = nil
  @State private var loadedImage: UIImage? = nil
  @State private var episodes: [Episode] = []
  var navigateBack: () -> Void
  
  var body: some View {
    ZStack {
      Color.black.edgesIgnoringSafeArea(.all)
      VStack {
        if let loadedImage = loadedImage {
          Image(uiImage: loadedImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 150)
            .cornerRadius(10)
        }
        Text("\(character.name)")
          .font(.system(size: 24, weight: .bold))
          .foregroundColor(.white)
        Text("\(character.status.rawValue)")
          .foregroundColor(.green)
        
        HStack {
          Text("Info")
            .foregroundColor(.white)
            .padding(.leading)
          Spacer()
        }
        
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 370, height: 100)
          .background(Color(red: 0.15, green: 0.16, blue: 0.22))
          .cornerRadius(16)
          .overlay(
            HStack {
              VStack(alignment: .leading, spacing: 8) {
                Text("Species:")
                  .foregroundColor(.white)
                Text("Type:")
                  .foregroundColor(.white)
                Text("Gender:")
                  .foregroundColor(.white)
              }
              Spacer()
              VStack(alignment: .trailing, spacing: 8) {
                Text(character.species)
                  .foregroundColor(.white)
                Text(character.type.isEmpty ? "None" : character.type)
                  .foregroundColor(.white)
                Text(character.gender.rawValue)
                  .foregroundColor(.white)
              }
            }
              .padding()
          )
        
        HStack {
          Text("Origin")
            .foregroundColor(.white)
            .padding(.leading)
          Spacer()
        }
        Rectangle()
          .foregroundColor(Color(red: 0.15, green: 0.16, blue: 0.22))
          .frame(width: 370, height: 100)
          .cornerRadius(16)
          .overlay(
            HStack {
              ZStack {
                Color(red: 0.1, green: 0.11, blue: 0.16)
                  .cornerRadius(10)
                  .frame(width: 65, height: 65)
                Image("planet")
                  .resizable()
                  .frame(width: 25, height: 25)
              }
              .padding(.leading, 8)
              
              VStack(alignment: .leading, spacing: 8) {
                Text(character.origin.name.isEmpty ? "Unknown" : character.origin.name)
                  .foregroundColor(.white)
                if let locationInfo = locationInfo {
                  if locationInfo.type.isEmpty {
                    Text("Unknown")
                      .foregroundColor(.green)
                  } else {
                    Text(locationInfo.type)
                      .foregroundColor(.green)
                  }
                } else {
                  Text("Unknown")
                    .foregroundColor(.white)
                }
              }
              .padding()
              Spacer()
            }
          )
        
        HStack {
          Text("Episodes")
            .foregroundColor(.white)
            .padding(.leading)
          Spacer()
        }
        
        ScrollView {
          VStack(spacing: 16) {
            ForEach(episodes) { episode in
              EpisodeRowView(episode: episode)
            }
          }
          .padding()
        }
        Spacer()
      }
      .onAppear {
        loadImage()
        fetchLocationInfo()
        fetchEpisodes()
      }
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: backButton)
    }
  }
  
  private var backButton: some View {
    Button(action: {
      self.navigateBack()
    }) {
      Image(systemName: "chevron.left")
        .foregroundColor(.white)
        .imageScale(.large)
    }
  }
  
  private func loadImage() {
    if let imageURL = URL(string: character.image) {
      URLSession.shared.dataTask(with: imageURL) { data, response, error in
        if let error = error {
          print("Error loading image: \(error)")
          return
        }
        
        if let data = data, let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self.loadedImage = image
          }
        }
      }.resume()
    }
  }
  
  private func fetchLocationInfo() {
    guard let locationURL = URL(string: character.origin.url) else {
      print("Invalid location URL")
      return
    }
    
    let task = URLSession.shared.dataTask(with: locationURL) { data, response, error in
      if let error = error {
        print("Error fetching location info: \(error)")
        return
      }
      
      if let data = data {
        do {
          let decoder = JSONDecoder()
          let locationInfo = try decoder.decode(LocationInfo.self, from: data)
          DispatchQueue.main.async {
            self.locationInfo = locationInfo
          }
        } catch {
          print("Error decoding location info: \(error)")
        }
      }
    }
    task.resume()
  }

  private func fetchEpisodes() {
    let episodeURLs = character.episode.compactMap { URL(string: $0) }
    
    DispatchQueue.global(qos: .background).async {
      var fetchedEpisodes: [Episode] = []
      let group = DispatchGroup()
      for episodeURL in episodeURLs {
        group.enter()
        
        URLSession.shared.dataTask(with: episodeURL) { data, response, error in
          defer { group.leave() }
          
          if let data = data {
            do {
              let decoder = JSONDecoder()
              let episode = try decoder.decode(Episode.self, from: data)
              fetchedEpisodes.append(episode)
            } catch {
              print("Error decoding episode: \(error)")
            }
          }
        }.resume()
      }
      
      group.notify(queue: .main) {
        self.episodes = fetchedEpisodes
      }
    }
  }
}
