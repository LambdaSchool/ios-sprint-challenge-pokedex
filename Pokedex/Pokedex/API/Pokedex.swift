//
//  PokedexController.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class Pokedex {
    var pokemon: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    // MARK: - Get pokemon
    func getPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        
        // MARK: - Build request URL
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // MARK: - Out into the world
        URLSession.shared.dataTask(with: request) { data, response, error in
            <#code#>
        }.resume()
        
    }
    
    // MARK: - Save Pokemon
    
}
