//
//  Model.swift
//  Pokedex
//
//  Created by Jerrick Warren on 10/26/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

class Model {
    static let shared = Model()
    private init (){}
    
    let baseURL = URL(string:"https://pokeapi.co")!
    
    // set up as an empty array
    var records: [Pokemon] = []
    
    // create a fetch method
    func fetchPokemon(name: String, completion: @escaping (Error?) -> Void){
        
        let requestURL = baseURL.appendingPathComponent("api")
            .appendingPathComponent("v2")
            .appendingPathComponent("pokemon")
            .appendingPathComponent(name)
    
        
}
