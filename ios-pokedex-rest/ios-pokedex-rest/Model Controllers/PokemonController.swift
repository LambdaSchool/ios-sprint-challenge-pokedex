//
//  PokemonController.swift
//  ios-pokedex-rest
//
//  Created by Conner on 8/10/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

class PokemonController {
    func getPokemon(searchTerm: String, completion: @escaping (Pokemon, Error?) -> Void) {
        let url = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error GET pokemon: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(pokemon, nil)
                } catch let error {
                    NSLog("Error decoding data from GET: \(error)")
                }
            }
        }.resume()
    }
    
    var pokemons: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
}
