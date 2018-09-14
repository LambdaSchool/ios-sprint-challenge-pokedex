//
//  PokemonController.swift
//  Pokedex
//
//  Created by Dillon McElhinney on 9/14/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import Foundation

class PokemonController {
    
    // MARK: - Properties
    private(set) var pokedex: [Pokemon] = []
    
    var pokedexSortedByID: [Pokemon] {
        return pokedex.sorted() { $0.id < $1.id }
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    // MARK: - CRUD Methods
    func createPokemon(_ pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func deletePokemon(_ pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        
        pokedex.remove(at: index)
    }
    
    // MARK: - Networking
    func searchForPokemon(searchText: String, completion: @escaping (Error?, Pokemon?) -> Void ) {
        var requestURl = baseURL.appendingPathComponent("pokemon")
        requestURl.appendPathComponent(searchText)
        
        URLSession.shared.dataTask(with: requestURl) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError(), nil)
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(nil, pokemon)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error, nil)
                return
            }
            
        }.resume()
    }
}
