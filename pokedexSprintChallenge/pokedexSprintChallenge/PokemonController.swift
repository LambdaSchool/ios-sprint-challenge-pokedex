//
//  PokemonController.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError
    case noData
    case noDecode
}

class PokemonController {

    
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    typealias CompletionHandler = (Error?) -> Void
    
    func performSearch(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
        
        if let error = error {
            NSLog("error searching for pokemon: \(error)")
            completion(.failure(.otherError))
            return
        }
            guard let data = data else {
                NSLog("Error getting data")
                completion(.failure(.noDecode))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(searchPokemon))
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(.failure(.noDecode))
                return
            }
    }.resume()
    
  }
    
}
