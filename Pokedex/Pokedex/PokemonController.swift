//
//  PokemonController.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 1/25/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemonList: [Pokemon] = []
    
    func savePokemon(pokemon: Pokemon) {
        pokemonList.append(pokemon)
    }
    
    func deletePokemon(index: IndexPath) {
        pokemonList.remove(at: index.row)
    }
    
    func searchPokemon(with term: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        let searchURL = baseURL.appendingPathComponent(term.lowercased())
        
        URLSession.shared.dataTask(with: searchURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned.")
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(Pokemon.self, from: data)
                let result = decodedData
                completion(result, nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
    }
    
}
