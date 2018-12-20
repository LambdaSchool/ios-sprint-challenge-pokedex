//
//  PokemonController.swift
//  Pokedex
//
//  Created by Scott Bennett on 9/21/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

private var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Properites
    
    var pokeDex: [Pokemon] = []
    
    // Search for Pokemon
    func searchForPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        // URL
        var requestURL =  baseURL
        requestURL.appendPathComponent(searchTerm)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // URLSession
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // Check if there is an error
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            // Check if data was received
            guard let data = data else {
                NSLog("Error fetching data No data received.")
                completion(nil, NSError())
                return
            }
            
            // Decode data
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                NSLog("Unable to decode data into result: \(error)")
                completion(nil, NSError())
            }
        }.resume()
    }
    
    func savePokemon(pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        pokeDex.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
//        guard let index = pokeDex.index(of: pokemon) else { return }
        
//        pokeDex.remove(at: index)
    }
    
}
