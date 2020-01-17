//
//  Auth.swift
//  PokeDex
//
//  Created by Aaron Cleveland on 1/17/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

enum NetworkError: Error {
    case noData
    case noDecode
    case badData
    case otherError
}


class Auth {
    
    let pokemon: [Pokemon] = []
    let pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    func fetchPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURL = baseURL?.appendingPathComponent(pokemonName.lowercased())
        guard let pokeURL = pokemonURL else { return }
        
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error occured fetching data: \(error)")
                completion(.failure(.badData))
                return
            }
            
            guard let data = data else {
                print("No data returned from data task")
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode Pokemon data object: \(error)")
            }
        }.resume()
    }
    
}
