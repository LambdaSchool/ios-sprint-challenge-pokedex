//
//  PokemonNetworkingClient.swift
//  Pokedex
//
//  Created by Austin Cole on 12/18/18.
//  Copyright © 2018 Austin Cole. All rights reserved.
//

import Foundation

class PokemonNetworkingClient {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    var pokemon: PokemonModel?
    
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Error?) -> Void) {
        let appendedURL = baseURL?.appendingPathComponent(searchTerm)
        
        URLSession.shared.dataTask(with: appendedURL!) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching search results.")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("Could not get data.")
                completion(NSError())
                return
            }
            
            // Do stuff with the results
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try jsonDecoder.decode(PokemonModel.self, from: data)
                self.pokemon = pokemon
                Model.shared.pokemon = pokemon
                completion(nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
}
