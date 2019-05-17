//
//  PokemonController.swift
//  Pokedex
//
//  Created by Thomas Cacciatore on 5/17/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

class PokemonController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemonResults: [Pokemon] = []
    var pokemon: Pokemon?
    
    func performSearch(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
    
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned")
                completion(NSError())
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemonSearchResult = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemonSearchResult
                guard let newPokemon = self.pokemon else { return }
                self.pokemonResults.append(newPokemon)
                print("we got a \(self.pokemon)")
                completion(nil)
            } catch {
                NSLog("Error decoding Pokemon: \(error)")
                completion(error)
            }
            
        }
            dataTask.resume()
    }
    
    
    
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "Post"
        case delete = "DELETE"
    }

}
