//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

fileprivate let HTTPMethod = (
    get: "GET",
    post: "POST"
)

enum NetworkError: String, Error {
    case otherError = "Unknown error occurred: see log for details."
    case badData = "No data received, or data corrupted."
    case noDecode = "JSON could not be decoded."
}

class PokemonController {
    var pokemonList: [Pokemon] = []
    
    let baseURL: URL = URL(string: "https://pokeapi.co/api/v2")!
    
    func performSearch(
        for pokemonName: String,
        completion: @escaping (Result<Pokemon,NetworkError>) -> Void
    ) {
        let searchURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print(NSError(domain: "", code: response.statusCode, userInfo: nil))
                completion(.failure(.otherError))
                return
            }
            
            if let error = error {
                print(error)
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let foundPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemonList.append(foundPokemon)
                completion(.success(foundPokemon))
            } catch {
                print(error)
                completion(.failure(.noDecode))
            }
        }
        task.resume()
    }
}
