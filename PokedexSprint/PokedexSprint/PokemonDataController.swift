//
//  PokemonDataController.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation
import UIKit

class PokemonDataController {
    let pokemonBool : Bool = UserDefaults.standard.bool(forKey: .pokemonIntializedKey)
    
    var pokemonArray : [Pokemon] = [Pokemon(pokemonName: "Venasaur")]
    
    var pokemonURL : URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("PokemonResults.plist")
    }
    
    init() {
        if pokemonBool == false {
            UserDefaults.standard.set(true, forKey: .pokemonIntializedKey)
            print("created \(pokemonBool)")
        } else {
            print("loaded \(pokemonBool)")
        }
    }
    
    func createData() {
        saveToPersistenceStore()
    }
    
    func saveToPersistenceStore() {
        guard let url = pokemonURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemonArray)
            try data.write(to: url)
            
        } catch {
            print("Not able to encode the data")
        }
    }
    
    func loadFromPersistenceStore() {
        let fm = FileManager.default
        guard let url = pokemonURL, fm.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            pokemonArray = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Not able to decode the data")
        }
    }
}

extension String {
    static let pokemonIntializedKey = "pokemonInitializedKey"
}
