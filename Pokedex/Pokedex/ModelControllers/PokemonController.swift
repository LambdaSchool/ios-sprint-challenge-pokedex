//
//  PokemonController.swift
//  Pokedex
//
//  Created by Chris Price on 3/21/20.
//  Copyright © 2020 com.chrispriiice. All rights reserved.
//

import Foundation

class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noAuth
        case unauthorized
        case otherError(Error)
        case noData
        case decodeFailed
    }
    
    var pokemonArray: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func savePokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
    
    func deletePokemon(index: Int) {
        pokemonArray.remove(at: index)
    }
    
    func fetchPokemon(named name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let url = baseURL.appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedData = try decoder.decode(Pokemon.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Unable to decode data: \(error)")
                completion(.failure(.decodeFailed))
            }
        }.resume()
    }
}
