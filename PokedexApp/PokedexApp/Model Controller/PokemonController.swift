//
//  PokemonController.swift
//  PokedexApp
//
//  Created by Nelson Gonzalez on 1/24/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class PokemonController {
    
//    static let shared = PokemonController()
//    private init () { }
    private(set) var pokemons: [Pokemon] = []
    
    func addPokemon(pokemon: Pokemon){
        pokemons.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else {return}
        pokemons.remove(at: index)
    }
    
    
 private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
 
    
    func searchPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        let url = baseUrl.appendingPathComponent(searchTerm.lowercased())
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if error != nil {
                NSLog("Error fetching data: \(error!)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data returned")
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
         //   decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
               // self.pokemons = pokemon
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
    }
    
    
    
}
