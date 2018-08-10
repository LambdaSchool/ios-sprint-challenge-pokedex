//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jonathan T. Miles on 8/10/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class PokemonController {
    // READ
    var pokedex: [Pokemon] = []
    
    // CREATE
    func createPokemon(withName name: String, id: Int, abilities: String, types: String) {
        let pokemon = Pokemon(name: name, id: id, abilities: abilities, types: types)
        pokedex.append(pokemon)
        // TODO: code for filling those categories with json data
    }
    
    // DELETE
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        pokedex.remove(at: index)
    }
    
    
    
}
