//
//  APIController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 17/01/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case requestError(Error)
    case noData
    case badData
}

class APIController {
    
    var pokemon: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    typealias FetchPokemonCompletionHandler = (Result<[Pokemon], NetworkError>) -> Void
    
    func fetchPokemon(called pokemon: Pokemon, completion: @escaping FetchPokemonCompletionHandler) {
        let requestURL = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(pokemon.name)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon request: \(error)")
                completion(.failure(.requestError(error)))
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching pokemon data")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemonJSON = try decoder.decode([Pokemon].self, from: data)
                self.pokemon = pokemonJSON
                completion(.success(pokemonJSON))
            } catch {
                NSLog("Error decoding pokemon data: \(error)")
                completion(.failure(.badData))
            }
        }.resume()
    }
}
