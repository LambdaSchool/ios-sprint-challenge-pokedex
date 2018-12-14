//
//  PokemonModel.swift
//  PokeDex
//
//  Created by Vijay Das on 12/14/18.
//  Copyright © 2018 Vijay Das. All rights reserved.
//

import Foundation

class PokemonModel {
    static let shared = PokemonModel()
    private init () {}
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    
    private var pokemons: [Pokemon] = []
    
    var numberOfPokemon: Int {
        return pokemons.count
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }
    
    
    func search(for searchTerm: String, completion: @escaping (Error?) -> Void ) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        // need to figure out how the API accepts search
        
    }
    
    // dataTask here
    
    
    
    
}
