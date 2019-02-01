//
//  PokemonController.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

// file for model controller

import Foundation

class PokemonController {

    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    
    var pokemonArray: [Pokemon] = []
    
    func searchPokemon(with term: String, completion: @escaping (Pokemon?, Error?) -> Void){
        
        let searchURL = baseURL?.appendingPathComponent(term.lowercased())
        

        
        
        
        
    }
    
}
