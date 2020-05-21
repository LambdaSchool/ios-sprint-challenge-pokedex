//
//  PokemonAPIController.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import UIKit
let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
class PokemonAPIController {
    
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData
        case failedFetching
        
    }
    
    
    
    private lazy var decoder = JSONDecoder()
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Result <Pokemon, NetworkError>) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
//        request.httpMethod = HTTPMethod.get.rawValue
        
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("Failed fetching pokemon: \(error)")
                completion(.failure(.failedFetching))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("Error receiving \(response)")
                completion(.failure(.failedFetching))
                return
            }
            guard let data = data else {
                print("Error no data received")
                completion(.failure(.noData))
                return
            }
            do {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let pokemon = try self.decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding pokemon: \(error)")
                completion(.failure(.noData))
            }
        }
        task.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Failed fetching image: \(error)")
                return
            }
            guard let data = data else {
                print("Error no data received")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    var pokedex: [Pokemon] = []
}
