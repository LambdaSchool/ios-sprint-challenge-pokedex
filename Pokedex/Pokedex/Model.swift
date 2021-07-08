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

    // set up as an empty array
    var records: [Pokemon] = []
    
    let baseURL = URL(string:"https://pokeapi.co")!
    
    // create a fetch method
    func fetchPokemon(name: String, completion: @escaping () -> Void){
        
        let requestURL = baseURL.appendingPathComponent("api")
            .appendingPathComponent("v2")
            .appendingPathComponent("pokemon")
            .appendingPathComponent(name)
    
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard error == nil,
                let data = data else {
                    NSLog("Unable to fetch data")
                    completion()
                    return
            }
            
            do {
                let searchResults = try JSONDecoder().decode(PokemonResults.self, from: data)
                self.records = searchResults.results
                completion()
            } catch {
                NSLog("Unable to decode data into news entries")
                completion()
            }
        }
        dataTask.resume()
}
}
