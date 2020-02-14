//
//  PokemonController.swift
//  PokemonSprint
//
//  Created by Elizabeth Wingate on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError
    case badData
    case decodingError
}

class PokemonController {

    // MARK: - Properties

    var pokemonList: [Pokemon] = []
    private let baseUrl = URL(fileURLWithPath: "https://pokeapi.co/api/v2")

        func fetchPokemon(with nameOrID: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
            var fetchPokemonUrl = baseUrl.appendingPathComponent("pokemon")
            fetchPokemonUrl.appendPathComponent(nameOrID)

            var request = URLRequest(url: fetchPokemonUrl)
            request.httpMethod = HTTPMethod.get.rawValue

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Error receiving pokemon data: \(error)")
                    completion(.failure(.otherError))
                    return
                }

                guard let data = data else {
                    completion(.failure(.badData))
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    print("Error decoding pokemon object: \(error)")
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        guard let imageUrl = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(image))
        }.resume()
    }
}
