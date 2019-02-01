//
//  PokemonController.swift
//  Pokedex
//
//  Created by Paul Yi on 2/1/19.
//  Copyright © 2019 Paul Yi. All rights reserved.
//

import Foundation

class PokemonController {
    var pokemon: Pokemon?
    var pokedex: [Pokemon] = []
    
    // Add a baseURL constant
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    // MARK: - Create & Delete methods
    func create(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        pokedex.remove(at: index)
    }
    
    func fetch(searchName: String, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(searchName.lowercased())
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a data task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Check for errors
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                completion(error)
                return
            }
            // Unwrap the data
            guard let data = data else {
                NSLog("Data was not received.")
                completion(error)
                return
            }
            // Decode pokemon from the data returned from the data task
            do {
                let jsonDecoder = JSONDecoder()
                let decodedPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = decodedPokemon
                // call completion with nil
                completion(nil)
            }
            catch {
                NSLog("Error: \(error.localizedDescription)")
                // call completion with error
                completion(error)
                return
            }
            // Newly-initiated tasks begin in a suspended state, so you need to call this method to start the task
        }.resume()
    }
}
