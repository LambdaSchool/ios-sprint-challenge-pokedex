//
//  PokemonController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class PokemonController {
    var pokemon: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noDataReturned
        case noBearer
        case badAuth
        case apiError
        case noDecode
    }
    
    func searchPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent(searchTerm)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(.failure(.apiError))
                return
            }
            guard let data = data else {
                NSLog("Error retrieving data")
                completion(.failure(.noDataReturned))
                return
            }
            do {
                let decoder = JSONDecoder()
                let searchPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(searchPokemon))
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    } // end of search pokemon
}
