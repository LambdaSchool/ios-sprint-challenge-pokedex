//
//  SavedPokemonList.swift
//  Pokedex
//
//  Created by Ivan Caldwell on 12/7/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
struct SavedPokemonList: Codable {
    let saved: [Pokemon]
    
    func numberOfPokemon() -> Int {
        return saved.count
    }
}
