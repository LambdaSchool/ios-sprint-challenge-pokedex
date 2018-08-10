//
//  PokemonController.swift
//  Pokedex
//
//  Created by Carolyn Lea on 8/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController
{
    var pokemons: [Pokemon] = []
    
    func createPokemon(name: String, completion: @escaping (Error?) -> Void)
    {
        let pokemon = Pokemon(name: name, id: 100, abilities: "ability", types: "type")
        print(pokemon)
    }
    
    func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void)
    {
        let url = baseURL.appendingPathComponent(searchTerm)
        
        print("This is the searchQueryItem \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("error \(error)")
                completion(self.pokemons, error)
                return
            }
            
            guard let data = data else {
                completion(self.pokemons, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(PokemonSearchResult.self, from: data)
                let pokemons = searchResults.results
                completion(pokemons, nil)
            } catch {
                NSLog("Unable to decode data into pokemon: \(error)")
                completion(nil, error)
                return
            }
            
        }.resume()
        
    }
}




// name: https://pokeapi.co/api/v2/pokemon/<NAME>
