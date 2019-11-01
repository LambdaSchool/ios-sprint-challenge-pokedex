//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by brian vilchez on 11/1/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation


enum HttpMethod: String {
    case put = "PUT"
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError
    case noData
    case noDecode
}


class PokemonAPIController {
    
    //MARK: - properties
    var pokemons: [Pokemon] = []
    var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    typealias completionHandler = (NetworkError?) -> Void
    
    //MARK: - methods
    func savePokemon(with pokemon: Pokemon) {
           pokemons.append(pokemon)
       }
       
    func searchForPokemon(with name: String, completion: @escaping (Result<Pokemon,Error>) -> Void) {
        let requestURL = baseURL.appendingPathComponent(name)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _ ,error) in
            if let error = error {
                NSLog("Error getting Pokemon: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                NSLog("Error retreiving DataTask")
                completion(.failure(NSError()))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemonData = try decoder.decode(Pokemon.self, from: data)
                print(pokemonData)
                completion(.success(pokemonData))
            } catch {
                NSLog("error Decoding Pokemon: \(error)")
                completion(.failure(error))
                return
            }
        }.resume()
        
        
    }

}
