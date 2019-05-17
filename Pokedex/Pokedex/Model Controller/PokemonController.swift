//
//  PokemonController.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import Foundation

class PokemonController {
    
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("name")
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error searching for pokemon: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let pokemonSearch = try decoder.decode(PokemonSearch.self, from: data)
                
                self.pokemon = pokemonSearch.results
                completion(NSError())
                
            } catch {
                NSLog("Error decoding PokemonSearch from data: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    var pokemon: [Pokemon] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
}
