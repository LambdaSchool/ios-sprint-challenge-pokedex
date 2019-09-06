//
//  APIController.swift
//  iOS Sprint Challenge Pokedex
//
//  Created by Andrew Ruiz on 9/6/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import Foundation

class APIController {
    
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/houndoom")!
    typealias CompletionHandler = (Error?) -> Void
    
    func getPokemon(completion: @escaping CompletionHandler = {_ in }) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error getting pokemon: \(error)")
            }
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil)
                return
            }
            do {
                let newPokemon = try JSONDecoder().decode(PokemonResult.self, from: data)
                print(newPokemon)
                self.pokemon = newPokemon.abilities
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
    }
}
