//
//  PokemonController.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case noDecode
}

class PokemonController {
    
    var pokemon: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
  

    func fetchAllPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let allPokemonURL = baseURL.appendingPathComponent("pokemon")
        
        var request = URLRequest(url: allPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                   if let response = response as? HTTPURLResponse,
                       response.statusCode == 401 {
                    completion(.failure(.otherError))
                       return
                   }
                   
                   if let error = error {
                    NSLog("Error getting request \(error)")
                    completion(.failure(.otherError))
                       return
                   }
                   
                   guard let data = data else {
                    completion(.failure(.badAuth))
                       return
                   }

                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = .iso8601
                   do {
                       let pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                   } catch {
                       print("Error decoding Pokemon objects: \(error)")
                    completion(.failure(.noDecode))
                       return
                   }
                   }.resume()
    }
}
    
    
    



