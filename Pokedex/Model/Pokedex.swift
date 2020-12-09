//
//  Pokedex.swift
//  Pokedex
//
//  Created by Alfredo Colon on 12/8/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

class Pokedex {
    
    // MARK: - Properties
    
    private var pokemon: [String: Pokemon]
    
    // MARK: - Init
    
    init() {
        self.pokemon = [ : ]
    }
    
    // MARK: - Methods
    
    func add(pokemon: Pokemon) {
        self.pokemon[pokemon.name] = pokemon
    }
    
    func fetchPokemonNames() -> [String] {
        return self.pokemon.keys.sorted()
    }
    
    func remove(pokemon: Pokemon) {
        self.pokemon.removeValue(forKey: pokemon.name)
    }
    
    func fetchPokemon(pokemonName: String) -> Pokemon? {
        guard let pokemon = self.pokemon[pokemonName] else { return nil }
        return pokemon
    }
}
