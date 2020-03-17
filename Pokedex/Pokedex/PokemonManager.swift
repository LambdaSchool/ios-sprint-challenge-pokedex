//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Lotanna Igwe-Odunze on 11/2/18.
//  Copyright © 2018 Lotanna. All rights reserved.
//

import Foundation
import UIKit

class PokemonManager {
    
    //Store Pokemon
    var pokeball: [Pokemon] = []
    
    //Initialise Pokemon only once
    init() {
    let initKey = "Check if pokemon already exists"
    let initCheck = UserDefaults.standard.bool(forKey: initKey)
        
        if initCheck == true {
            loadFromPersistence() } else { newPokemon() }
    }//End of initialisation.
    
    //Create Pokemon
    func newPokemon() {
        guard let thePokemon = foundPokemon else { return }
        pokeball.append(thePokemon) //Add it to the Pokeball array.
        saveToPersistence()
    }
    
    //Create File to Store Pokemon
    var pokemonFILEURL: URL? {
        let pokemonStorage = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = "pokemon.plist"
        return pokemonStorage?.appendingPathComponent(fileName)
    }

    
    //Save to Persistence
    func saveToPersistence() {
        let pokemonEncoder = PropertyListEncoder()//Prepare to manipulate the encoder by assigning it to a property.
        do {
            let pokemonData = try pokemonEncoder.encode(pokeball) //Encode pokeball array into data, and assign that data to pokemonData property.
            
            guard let pokeFile = pokemonFILEURL else { return }
            //Prepare to manipulate the pokemon file URL by assigning it to a property.
            
            try pokemonData.write(to: pokeFile) //Write the encoded data to the pokeFile using pokemonData.
            
        } catch { //In case of fatal error, customise this message so you know what's wrong and where it came from. It will appear in debug error log.
            NSLog("Something went wrong in the saveToPersistence function while encoding the pokemon file: \(error)")
        }
    }
    
    
    //Load from Persistence
    func loadFromPersistence() {
        do { //Do-Catch Statement
            guard let pokeFile = pokemonFILEURL,
                FileManager.default.fileExists(atPath: pokeFile.path) else  { return } //Prepare to manipulate the File URL by assigning it to a property. Then checks if the file exists at the pokemon storage path.
            let pokeData = try Data(contentsOf: pokeFile) //Assign data found in the file to a property.
            let pokemonDecoder = PropertyListDecoder() //Prepare to manipulate the decoder by assigning it to a property.
            self.pokeball = try pokemonDecoder.decode([Pokemon].self, from: pokeData)
        } catch { //Decode the data from pokeData into an array of Pokemon, and assign it to the Pokeball.
            NSLog("Something went wrong in the loadFromPersistence function while decoding the pokemon file: \(error)")
        }
    }
    
}
