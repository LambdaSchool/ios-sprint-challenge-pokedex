//
//  PokemonController.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case noDecode
}

class PokemonController {
    
    var pokemon: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
  

    func fetchAllPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError?>) -> Void) {
        let allPokemonURL = baseURL.appendingPathComponent("pokemon")
        
        var request = URLRequest(url: allPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                   if let response = response as? HTTPURLResponse,
                       response.statusCode == 401 {
                       completion(.badAuth)
                       return
                   }
                   
                   if let error = error {
                    completion(.failure(.otherError))
                       return
                   }
                   
                   guard let data = data else {
                       completion(.badData)
                       return
                   }

                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = .iso8601
                   do {
                       self.pokemon = try decoder.decode([Pokemon].self, from: data)
                       completion(nil)
                   } catch {
                       print("Error decoding Pokemon objects: \(error)")
                       completion(.noDecode)
                       return
                   }
                   }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }

        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.otherError))
                return
            }

            guard let data = data else {
                completion(.failure(.noAuth))
                return
            }

            guard let image = UIImage(data: data) else {
                completion(.failure(.noDecode))
                return
            }

            completion(.success(image))
        }.resume()
    }
    
    
    
}


