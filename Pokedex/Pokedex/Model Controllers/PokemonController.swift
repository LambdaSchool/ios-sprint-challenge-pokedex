//
//  PokemonController.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

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

class PokemonController {
    
    private let baseURL = URL(string: "http://poke-api.vapor.cloud/")
    var pokemon: Pokemon?
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        guard let pokemonUrl = baseURL?.appendingPathComponent("api/v2/pokemon/\(searchTerm)") else { return }
        
        var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Unable to decode data into Pokemon object: \(error.localizedDescription)")
                completion(.failure(.noDecode))
                return
            }
            
        }.resume()
    }
    
    // create function to fetch pokemon details
    func fetchPokemonDetails(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let pokemonUrl = baseURL?.appendingPathComponent("api/v2/pokemon/\(name)") else { return }
        
        var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding Pokemon: \(error.localizedDescription)")
                return
            }
        }.resume()
    }
    
}

