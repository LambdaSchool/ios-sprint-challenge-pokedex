//
//  PokemonController.swift
//  Pokedex
//
//  Created by Scott Bennett on 9/21/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import Foundation

private var baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    var pokemonResults: [Pokemon] = []
    let searchTerm = "133"
    
    
    func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        var requestURL =  baseURL
        requestURL.appendPathComponent(searchTerm)
                
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print(request)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data No data received.")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let search = try jsonDecoder.decode(SearchResults.self, from: data)
                self.pokemonResults = search.results
                completion(self.pokemonResults, nil)
            } catch {
                NSLog("Unable to decode data into result: \(error)")
                completion(nil, NSError())
            }
        }
        dataTask.resume()
    }
    
    func create(name: String, id: String, abilities: String, types: String, completion: @escaping (Error?) -> Void) {
        
    }
    
    func update(pokemon: Pokemon, name: String, id: String, abilities: String, types: String, completion: @escaping (Error?) -> Void) {
        
    }
    
}
