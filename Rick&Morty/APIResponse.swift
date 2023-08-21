//
//  APIResponse.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 19.08.2023.
//

import Foundation

struct APIResponse: Decodable {
  let info: Info
  let results: [Result]
}

struct Info: Decodable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}

struct Result: Decodable {
  
  let id = UUID()
  let characterID: Int
  let name: String
  let status: Status
  let species: String
  let type: String
  let gender: Gender
  let origin: Origin
  let location: Location
  let image: String
  let episode: [String]
  let url: String
  let created: String
  
  enum CodingKeys: String, CodingKey {
    case characterID = "id"
    case name, status, species, type, gender, origin, location, image, episode, url, created
  }
}

struct Origin: Decodable {
  let name: String
  let url: String
}

struct Location: Decodable {
  let name: String
  let url: String
}

struct Episode: Decodable, Identifiable {
  let id: Int
  let name: String
  let airDate: String
  let episode: String
  let characters: [String]
  let url: String
  let created: String
  
  enum CodingKeys: String, CodingKey {
    case id, name
    case airDate = "air_date"
    case episode, characters, url, created
  }
}

enum Gender: String, Decodable {
  case female = "Female"
  case male = "Male"
  case genderless = "Genderless"
  case unknown = "unknown"
}

enum Status: String, Decodable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown = "unknown"
}

struct LocationInfo: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}
