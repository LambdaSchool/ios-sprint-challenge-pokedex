//
//  PokemonController.swift
//  Pokedex
//
//  Created by Vici Shaweddy on 9/13/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    var pokemons: [Pokemon] = []
    
    private let baseUrl = URL(string: "http://poke-api.vapor.cloud/")
    
    func searchPokemon(with pokemonName: Pokemon, completion: @escaping (Result<[Pokemon], NetworkError>) -> ()) {
        guard let allPokemonUrl = baseUrl?.appendingPathComponent("api/v2/pokemon/\(pokemonName)") else { return }
        
        var request = URLRequest(url: allPokemonUrl)
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
            
            let decoder = JSONDecoder()
            do {
                let pokemons = try decoder.decode(([Pokemon].self), from: data)
                self.pokemons = pokemons
                completion(.success(pokemons))
            } catch {
                print("Error decoding Pokemons: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func fetchDetail(for name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let allPokemonUrl = baseUrl?.appendingPathComponent("api/v2/pokemon/\(name)") else { return }
        
        var request = URLRequest(url: allPokemonUrl)
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
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode((Pokemon.self), from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding Pokemon object: \(error)")
                completion(.failure(.noDecode))
            }
            }.resume()
    }
}
