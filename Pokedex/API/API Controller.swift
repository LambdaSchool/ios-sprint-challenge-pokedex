//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Andrew Ruiz on 10/4/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

class APIController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    
    
    func fetchPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
    }
}
