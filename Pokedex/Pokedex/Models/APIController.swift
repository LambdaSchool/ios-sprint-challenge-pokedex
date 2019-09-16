//
//  APIController.swift
//  Pokedex
//
//  Created by Casualty on 9/15/19.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import Foundation

class APIController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    private(set) var pokemons = [String]()
    
    func getPokemons(by searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(searchTerm.lowercased())")
        let request = URLRequest(url: pokemonURL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error ) in
            
            if let error = error {
                print(error)
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let newPokemon = try decoder.decode(Pokemon.self, from: data)
                print("You have successfully added a new pokemon: \(newPokemon)")
                completion(.success(newPokemon))
                
            } catch {
                print(error)
                completion(.failure(.noDecode))
            }
            }.resume()
    }
    
    func addPokemon(pokemon: String) {
        if !pokemons.contains(pokemon) {
            pokemons.append(pokemon)
        }
    }
    
    func removePokemon(at index: Int) {
        pokemons.remove(at: index)
    }
    
}

