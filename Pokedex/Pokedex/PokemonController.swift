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
    
    func fetchPokemon(name: String, completion: @escaping (Error?) -> Void){
        
        var requestURL = baseURL.appendingPathComponent(name)
        requestURL.appendPathExtension("json")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error performing fetch request: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Could not GET data")
                completion(NSError())
                return
            }
            
            
            do{
                let decodeResults = try JSONDecoder().decode(Pokemon.self, from: data)
//                self.pokemons = Array(decodeResults.values)
                self.pokemons.append(decodeResults)
                print(self.pokemons)
            } catch {
                NSLog("Error Decoding Data : \(error)")
                completion(error)
                return
            }
            
        }.resume()
        
        pokemons.sort{$0.name > $1.name}
        
    }
    
}
