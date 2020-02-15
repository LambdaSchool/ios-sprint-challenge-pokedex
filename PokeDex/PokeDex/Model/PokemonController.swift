//
//  PokemonController.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation

struct staticValues {
  
    static var pokemonLibraryPersistenceFileName: String = "PokemonLibrary.plist"
}


class PokemonController {
    
    // MARK: - Properties
    
    var pokeDex: [Pokemon] = []
    var pokemonLibraryURL: URL?{
       let fileManager = FileManager.default
       guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let listURL = documentsDir.appendingPathComponent(staticValues.pokemonLibraryPersistenceFileName)
           
           return listURL
       }
    
    // MARK: - Methods
    
    func addPokemon(pokemon: Pokemon) {
        let newPokemon = pokemon
        pokeDex.append(newPokemon)
        saveToPersistentStore()
    }
    
    // MARK: Persistence
    
    func saveToPersistentStore(){
            
            guard let pokemonLibraryURL = pokemonLibraryURL else { return }
            
            let encoder = PropertyListEncoder()
            do {
             
                 let listData = try encoder.encode(pokeDex)
                 try listData.write(to: pokemonLibraryURL)
             
         } catch {
             print("Error encoding books array: \(error)")
         }
     }
     
     func loadFromPersistnetStore (){
         
         guard let pokemonLibraryURL = pokemonLibraryURL else { return }
         
         do {
             let decoder = PropertyListDecoder()
             let pokemonLibraryData = try Data(contentsOf: pokemonLibraryURL)
             let pokemonLibraryArray = try decoder.decode([Pokemon].self, from: pokemonLibraryData)
             pokeDex = pokemonLibraryArray
         } catch {
             print("Error decoding readList: \(error)")
         }
     }
}
