//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class PokemonModel {
    // MARK: - Singleton
    static let shared = PokemonModel()
    
    private init() {
        loadData()
    }
    
    var savedPokemon: [Pokemon] = []
    
    //Computed property: number of Pokemon saved
    var numberOfPokemonSaved: Int {
        return savedPokemon.count
    }
    
    // MARK: - CRUD Methods
    func add(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
         print("*** Added the Pokemon ***")
        saveData()
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return savedPokemon[indexPath.row]
    }
    
    func remove(pokemonAtIndex index: Int) {
        savedPokemon.remove(at: index)
        saveData()
    }
    
    
    // MARK: - Local perstance
    func saveData() {
        // TODO Implement saveData
    }
    
    func loadData() {
        // TODO Implement saveData
    }
    
} //End of class
