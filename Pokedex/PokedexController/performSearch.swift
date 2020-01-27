//
//  performSearch.swift
//  Pokedex
//
//  Created by alfredo on 1/26/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

extension PokedexController{

    
    func performSearch(_ textFieldText: String)->[String]{
        let pokemonNames = getPokemonNames()
        var matchedPokemon = pokemonNames.filter { name in
            name.localizedCaseInsensitiveContains(textFieldText)
        }
        
        return matchedPokemon  
    }
}
