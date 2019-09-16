//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class PokemonAPIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    var searchResult: Pokemon?
    
    func getPokemon(for pokemon: String, completion: @escaping (Error?) -> Void) {
        guard let searchURL = baseURL?.appendingPathComponent("/pokemon/\(pokemon)") else { return }
        
        print("Method Started")
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        print("Request URL Created")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                print("Error found: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Data Not Found")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.searchResult = pokemon
                completion(nil)
                print("Pokemon Found")
            } catch {
                print("Error decoding JSON data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
    }
}
