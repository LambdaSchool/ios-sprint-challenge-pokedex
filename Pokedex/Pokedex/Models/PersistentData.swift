//
//  SearchResult.swift
//  Sprint 3: Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
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
        try? (savedPokemon as NSArray).write(to: fileURL)
    }
    
    func loadData() {
        if let savedData = NSArray(contentsOf: fileURL) as? [Pokemon] {
            savedPokemon = savedData
            print("The number of saved records restored = \(savedPokemon.count)")
        }
    }
}
