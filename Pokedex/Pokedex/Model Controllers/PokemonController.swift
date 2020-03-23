//
//  PokemonController.swift
//  Pokedex
//
//  Created by Waseem Idelbi on 3/22/20.
//  Copyright © 2020 WaseemID. All rights reserved.
//

import UIKit

class PokemonController {
    
    //MARK: -Properties-
    
    var pokemonList: [ConvenientToSavePokemon] = []
    var pokemonForDisplay: Pokemon?
    
    
    //MARK: -Methods-
    
    func savePokemon(name: String, id: Int, abilities: String, types: String, image: Data) {
        let savedPokemon = ConvenientToSavePokemon(name: name, id: id, abilities: abilities, types: types, image: image)
        pokemonList.insert(savedPokemon, at: 0)
    }
    
    //MARK: -API Section-
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Error?) -> Void) -> Pokemon {
        let pokemonURL = (baseURL?.appendingPathComponent("/pokemon"))!
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error caused by: \(String(describing: error))")
                completion(error!)
                return
            }
            guard let data = data else {
                print("Could not retreive data because: \(String(describing: error))")
                completion(error!)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let searchedPokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokemonForDisplay = searchedPokemon
            } catch {
                print("Could not decode data because: \(error)")
            }
            completion(nil)
        }.resume()
       return pokemonForDisplay!
    }
    
} //End of class
