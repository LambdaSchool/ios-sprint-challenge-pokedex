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
    
    var pokemonResults: [Pokemon] = []
    
    func searchPokemon(with term: String, completion: @escaping (Error?) -> Void) {
        
        let searchURL = baseURL.appendingPathComponent(term)
        
        let jsonURL = searchURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: jsonURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned.")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode([Pokemon].self, from: data)
                self.pokemonResults = decodedData
                completion(nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(error)
                return
            }
        }.resume()
        
    }
    
}
