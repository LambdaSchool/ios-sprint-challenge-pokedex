//
//  APIController.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class APIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemon: [Pokemon] = []

    // create function to fetch details
    
    func fetchPokemonDetails(for pokemonName: String, completion: @escaping ( NetworkError?) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonName)
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let _ = error {
                completion(.otherError)
                return
            }
            
            guard let data = data else {
                completion(.badData)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.pokemon = try decoder.decode([Pokemon].self, from: data)
                completion(nil)
            } catch {
                print("Error retrieving pokemon objects: \(error)")
                completion(.noDecode)
                return
            }
        }.resume()
    }
    
}
