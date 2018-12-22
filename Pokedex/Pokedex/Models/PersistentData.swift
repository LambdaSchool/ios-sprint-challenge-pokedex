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
    
    // MARK: - CRUD Methods
    func add(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
        saveData()
    }
    
    
    // MARK: - Local perstance
    func saveData() {
        // TODO Implement saveData
    }
    
    func loadData() {
        // TODO Implement saveData
    }
}
