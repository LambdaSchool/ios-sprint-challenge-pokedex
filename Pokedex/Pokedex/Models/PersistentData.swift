//
//  PersistentData.swift
//  Pokedex
//
//  Created by Sameera Roussi on 5/10/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import UIKit

class PersistentData {
    
    // MARK: - Singleton
    static let shared = PersistentData()
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
        saveData()
    }
    
    func getPokemon(at index: Int) -> Pokemon {
        return savedPokemon[index]
    }
    
    func removePokemon(at index: Int) {
        savedPokemon.remove(at: index)
        saveData()
    }
    
    // MARK: - Local persistent
    let fileURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Library")
        .appendingPathComponent("Pokedex")
        .appendingPathExtension(".pList")
    
    func saveData() {
    }
    
    func loadData() {
    }
}

