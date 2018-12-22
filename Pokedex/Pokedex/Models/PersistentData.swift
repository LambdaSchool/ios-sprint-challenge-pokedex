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
    
    
    
    
    // MARK: - Local perstance    
    let fileURL = URL(fileURLWithPath: NSHomeDirectory())
        .appendingPathComponent("Library")
        .appendingPathComponent("Pokemon")
        .appendingPathExtension(".pList")
    
    func saveData() {
        try? (savedPokemon as? NSArray)?.write(to: fileURL)
    }
    
    func loadData() {
        if let savedPokemon = NSArray(contentsOf: fileURL) as? [Pokemon] {
            self.savedPokemon = savedPokemon
        }
    }
}
