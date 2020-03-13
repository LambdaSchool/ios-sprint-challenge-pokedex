//
//  SearchController.swift
//  Pokedex
//
//  Created by Bradley Diroff on 3/13/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badUrl
    case otherError
    case badData
    case noDecode
}

class SearchController {
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2")!
    
    var pokemon: Pokemon?
    
    func fetchPokemon(for pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let animalUrl = baseUrl.appendingPathComponent("pokemon/\(pokemon.lowercased())")
        
        var request = URLRequest(url: animalUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        print("THIS IS THE REQUEST: \(request)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving animal name data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("Server responded with no data to decode")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            do {
                let newPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(newPokemon))
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
}
