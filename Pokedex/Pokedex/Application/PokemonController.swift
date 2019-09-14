//
//  PokemonController.swift
//  Pokedex
//
//  Created by Dillon P on 9/14/19.
//  Copyright © 2019 Lambda iOSPT2. All rights reserved.
//

import Foundation


class PokemonController {
    
    var pokemon: Pokemon?
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    func searchForPokemon(with name: String, completion: @escaping (Error?) -> Void) {
        guard let baseURL = baseURL else {
            completion(NSError())
            return
        }
        
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(name)")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching pokemon details: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
            } catch {
                print("Unable to decode data into search object: \(error)")
                completion(NSError())
                return
            }
        }.resume()
        
    }
    
}
