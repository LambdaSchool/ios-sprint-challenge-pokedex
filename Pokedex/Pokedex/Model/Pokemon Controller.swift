//
//  Pokemon Controller.swift
//  Pokedex
//
//  Created by Welinkton on 9/21/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class PokemonController {
    
    
    
    var pokemon: Pokemon?
    
    let baseURL = URL(string: "https://pokeapi.co")!
    
    var pokedex: [Pokemon] = []
    
    // CRUD -
    
    // Save Pokemon
    
    // Delete Pokemon
    
    
    //Search API ( URL, Session, dataTasks, errors, resume
    func searchPokemon(name:String, completion: @escaping (Error?) -> Void){
        
        let requestURL = baseURL.appendingPathComponent("api").appendingPathComponent("v2").appendingPathComponent("pokemon").appendingPathComponent("name")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
    }
}
