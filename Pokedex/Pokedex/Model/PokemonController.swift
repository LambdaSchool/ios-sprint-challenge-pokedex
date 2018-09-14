//
//  PokemonController.swift
//  Pokedex
//
//  Created by Dillon McElhinney on 9/14/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class PokemonController {
    private(set) var pokemonArray: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func searchForPokemon(searchText: String, completion: @escaping (Error?) -> Void ) {
        var requestURl = baseURL.appendingPathComponent("pokemon")
        requestURl.appendPathComponent(searchText)
        
        URLSession.shared.dataTask(with: requestURl) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError())
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemonArray.append(pokemon)
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
}
