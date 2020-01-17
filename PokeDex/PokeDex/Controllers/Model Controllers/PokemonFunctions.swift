//
//  PokemonFunctions.swift
//  PokeDex
//
//  Created by Aaron Cleveland on 1/17/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import UIKit

class PokemonFunctions {
    
    let auth = Auth()
    
    func addPokemon(pokemon: Pokemon) {
        auth.pokemon.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let index = auth.pokemon.firstIndex(of: pokemon) else { return }
        auth.pokemon.remove(at: index)
    }
}
