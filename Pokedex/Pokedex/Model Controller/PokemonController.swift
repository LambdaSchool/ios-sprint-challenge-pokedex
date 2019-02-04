//
//  PokemonController.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class PokemonController {
    var pokedex: [Pokemon] = []
    var pokedexSortedByID: [Pokemon] {
        return pokedex.sorted() { $0.id < $1.id }
    }
    var pokedexSortedByName: [Pokemon] {
        return pokedex.sorted() { $0.name < $1.name }
    }
    
    // Add a baseURL constant
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    // MARK: - Create & Delete methods
    func createPokemon(_ pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func deletePokemon(_ pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        pokedex.remove(at: index)
    }
    
    // MARK: - Networking
    
    func searchForPokemon(searchText: String, completion: @escaping (Error?, Pokemon?) -> Void ) {
        var requestURl = baseURL.appendingPathComponent("pokemon")
        requestURl.appendPathComponent(searchText)
        
        URLSession.shared.dataTask(with: requestURl) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError(), nil)
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(nil, pokemon)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error, nil)
                return
            }
            
            }.resume()
    }
    
    func fetchImageFor(pokemon: Pokemon, completion: @escaping (Error?, Pokemon?) -> Void ){
        guard let requestURL = URL(string: pokemon.sprites.frontDefault) else {
            NSLog("Was unable to make URL from sprite string")
            completion(NSError(), nil)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching image: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError(), nil)
                return
            }
            
            pokemon.imageData = data
            completion(nil, pokemon)
            return
            
            }.resume()
    }
}
