//
//  PokemonController.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

class PokemonController {
    
    var pokeDex: [Pokemon] = []
    
    func addPokemon(pokemon: Pokemon) -> Pokemon {
        let newPokemon = pokemon
        pokeDex.append(newPokemon)
        return newPokemon
    }
    
//    func addToPokeDex(pokemon: Pokemon)
    
}
