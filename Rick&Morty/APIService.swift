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
}
