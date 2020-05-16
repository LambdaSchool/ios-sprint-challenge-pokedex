//
//  PokemonAPIController.swift
//  pokedex
//
//  Created by Rob Vance on 5/15/20.
//  Copyright © 2020 Robs Creations. All rights reserved.
//

import Foundation

class PokemonAPIController {
    
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData
        case failedFetching
        
    }
    var pokedex: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    
    func fetchPokemon(for text: String, completion: @escaping (Result <Pokemon, NetworkError>) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("pokemon/\(text.lowercased())")
        var request = URLRequest(url: requestURL)
        print("getPokemonURL = \(requestURL.absoluteString)")
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding pokemon: \(error)")
                completion(.failure(.noData))
            }
        }
        task.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
}
