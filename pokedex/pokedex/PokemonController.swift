//
//  PokemonController.swift
//  pokedex
//
//  Created by ronald huston jr on 5/8/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation


class PokemonController {
    
    // MARK: - class properties
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    
    func fetchPokemon(pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case fetchFail
    case badData
    case noDecode
    case noData
}
