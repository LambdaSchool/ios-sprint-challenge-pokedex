//
//  PokemonController.swift
//  Pokedex
//
//  Created by Fabiola S on 9/13/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badData
    case noDecode
    case otherError
}

class PokemonController {
    
    var pokedex: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func fetchPokemon(with search: String, completion: @escaping (Result<[String], NetworkError>) -> Void) {
        
        let allPokemonURL = baseURL.appendingPathComponent("pokemon")
        var request = URLRequest(url: allPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemonNames = try decoder.decode([String].self, from: data)
                completion(.success(pokemonNames))
            } catch {
                print("Error decoding Pokemon names: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchPokemonDetails(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("\(pokemonName)")
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
               let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding Pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
}
