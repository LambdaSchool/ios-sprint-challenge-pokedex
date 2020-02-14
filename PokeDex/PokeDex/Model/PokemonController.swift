//
//  PokemonController.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

class PokemonController {
    
    // MARK: - Properties
    
    var pokeDex: [Pokemon] = []
    let apiContrllet = APIController()
    
    // MARK: - Methods
    
    func addPokemon(pokemon: Pokemon) {
        let newPokemon = pokemon
        pokeDex.append(newPokemon)
//        return newPokemon
    }
}
