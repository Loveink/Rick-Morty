//
//  APIService.swift
//  Rick&Morty
//
//  Created by Александра Савчук on 19.08.2023.
//

import Foundation
import UIKit

class APIService {

    let charactersURL = URL(string: "https://rickandmortyapi.com/api/character")!
    let locationsURL = URL(string: "https://rickandmortyapi.com/api/location")!
    let episodesURL = URL(string: "https://rickandmortyapi.com/api/episode")!

    enum ServiceError: Error {
        case genericFailure
        case failedToDecodeData
        case invalidStatusCode
    }

    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCharacters(completion: @escaping (Swift.Result<APIResponse, Error>) -> Void) {
        let task = session.dataTask(with: charactersURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(APIResponse.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    func fetchEpisodes(completion: @escaping (Swift.Result<[Episode], Error>) -> Void) {
        let task = session.dataTask(with: episodesURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([Episode].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

    func fetchLocations(completion: @escaping (Swift.Result<[Location], Error>) -> Void) {
        let task = session.dataTask(with: locationsURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode([Location].self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
