//
//  PokemonController.swift
//  Pokedex (Sprint)
//
//  Created by Nathan Hedgeman on 6/15/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
}

class PokemonController {
    
    //Properties
    var pokemonSearchResult: [Pokemon] = []
    var pokemonList: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    
    func searchPokemon(pokemonName: String, completion: @escaping (Error?) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error reaching data from URL: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemonResult = try decoder.decode(Pokemon.self, from: data)
                self.pokemonSearchResult.append(pokemonResult)
            }catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(error)
                return
            }
        }
        print(pokemonSearchResult)
    }
    
    func getPokemon() {
        //MARK: Fetch pokemon data
    }
    
    func getPokemonImage() {
        //Fetch Image
        let imageBaseURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon")
    }
    
}
