//
//  PokemonController.swift
//  SprintChallengePokedex
//
//  Created by Chad Rutherford on 12/6/19.
//  Copyright © 2019 lambdaschool.com. All rights reserved.
//

import Foundation

class PokemonController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var pokemon = [Pokemon]() {
        didSet {
            saveToPersistentStore()
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Initialization
    init() {
        loadFromPersistentStore()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Persistence
    var persistentFileURL: URL? = {
        let fm = FileManager.default
        guard let documentsDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent("Pokemon.plist")
    }()
    
    func saveToPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let pokemonData = try encoder.encode(pokemon)
            try pokemonData.write(to: fileURL)
        } catch let encodeError {
            print("Error encoding Pokemon objects: \(encodeError.localizedDescription)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let fileURL = persistentFileURL, fileManager.fileExists(atPath: fileURL.path) else { return }
        let decoder = PropertyListDecoder()
        do {
            let pokemonData = try Data(contentsOf: fileURL)
            let pokemon = try decoder.decode([Pokemon].self, from: pokemonData)
            self.pokemon = pokemon
        } catch let decodeError {
            print("Error decoding Pokemon objects: \(decodeError.localizedDescription)")
        }
    }
}
