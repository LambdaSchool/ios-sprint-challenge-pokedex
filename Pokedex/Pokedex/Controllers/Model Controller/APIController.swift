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
    case unexpectedStatusCode
}

class APIController {
    
    var pokemon: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    typealias FetchPokemonCompletionHandler = (Result<Pokemon, NetworkError>) -> Void
    
    func fetchPokemon(called pokemonName: String, completion: @escaping FetchPokemonCompletionHandler) {
        let requestURL = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(pokemonName.lowercased())
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching pokemon request: \(error)")
                completion(.failure(.requestError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Error with response")
                completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                NSLog("Error fetching pokemon data")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemonJSON = try decoder.decode(Pokemon.self, from: data)
                self.pokemon.append(pokemonJSON)
                completion(.success(pokemonJSON))
            } catch {
                NSLog("Error decoding pokemon data: \(error)")
                completion(.failure(.badData))
            }
        }.resume()
    }
}
