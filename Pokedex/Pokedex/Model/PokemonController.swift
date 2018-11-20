//
//  PokemonController.swift
//  Pokedex
//
//  Created by Farhan on 9/14/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import Foundation

class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemons: [Pokemon] = []
    
    func createPokemon(pokemon: Pokemon){
        
        pokemons.append(pokemon)
        
    }
    
    func deletePokemon(_ pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        
        pokemons.remove(at: index)
    }
    
    
    func fetchPokemon(name: String, completion: @escaping (Error?, Pokemon?) -> Void) {
        
        var requestURL = baseURL.appendingPathComponent(name)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error performing fetch request: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("Could not GET data")
                completion(NSError(), nil)
                return
            }
            
            do{
                let decodedPokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(nil, decodedPokemon)
            } catch {
                NSLog("Error Decoding Data : \(error)")
                completion(error, nil)
                return
            }
            
        
        }.resume()
     
    }
    
}
