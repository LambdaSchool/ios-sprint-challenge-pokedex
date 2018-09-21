//
//  PokemonController.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class PokemonController {
    
    // MARK: - Porperties
    
    var pokedex: [Pokemon] = []
    
    // MARK: - Base URL
    
    let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!
    
    // MARK: - REST API
    
    func performSearch(searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent(searchTerm)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokedex.append(pokemon)
                completion(nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
            
           completion(nil)
        }.resume()
    }
    
    
    // MARK: - CRUD
    
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        pokedex.remove(at: index)
    }
}
