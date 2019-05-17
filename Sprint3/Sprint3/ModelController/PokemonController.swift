//
//  PokemonController.swift
//  Sprint3
//
//  Created by Kobe McKee on 5/17/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation

class PokemonController {
    
    
    var pokemons: [Pokemon] = []
    
    let baseURL = URL(string: "http://poke-api.vapor.cloud/")!
    
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
    
    
    
    func savePokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func deletePokemon(pokemonIndex: Int) {
        pokemons.remove(at: pokemonIndex)
    }
    
    
    
    func searchPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let requestURL = baseURL
            .appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error searching pokemon: \(error)")
                completion(.failure(.apiError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from search")
                completion(.failure(.noDataReturned))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding pokemon")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
