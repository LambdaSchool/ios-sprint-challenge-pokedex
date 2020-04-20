//
//  SearchPokemon.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError
    case noData
    case noDecode
    case failedFetch
}

class SearchPokemonController {
    var pokemons: [Pokemon] = []
    
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func performSearch(for searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        print(pokemonURL)
        
        var request = URLRequest(url: pokemonURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(.failure(.failedFetch))
                return
            }
            
            guard let data = data else { completion(.failure(.noData)); return }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(searchResults))
            } catch {
                print("Unable to decode data into object of type: \(error)")
                completion(.failure(.noDecode))
            }
        }
        
        dataTask.resume()
    }
    
    // save
    
    func save(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
}

