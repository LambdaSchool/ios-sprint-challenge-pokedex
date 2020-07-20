//
//  PokemonPlist.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation

class SavedPokedex {
    
    var pokemon: [Pokemon] = []
    
    var pokedexURL: URL? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let readingListURL = documentsDirectory?.appendingPathComponent("pokedexURL.plist")
        return readingListURL
    }
    
    func saveToPersistentStore () {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemon)
            try data.write(to: pokedexURL!)
        } catch {
            print("Error")
        }
    }
    
    func loadFromPersistentStore () {
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: pokedexURL!)
            pokemon = try decoder.decode([Pokemon].self, from: data)
        } catch  {
            print("loadPersistentStore \(error)")
        }
    }
}
