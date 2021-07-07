//
//  ApiController.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 1/17/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case otherError
    case codeError
    case badData
    case noDecode
}

class ApiController {
    var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")! // Could crash

    var pokemonArray: [Pokemon] = []
    
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokeUrl = baseURL.appendingPathComponent(name) // or id?
        
        var request = URLRequest(url: pokeUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200, response.statusCode != 401 {
                completion(.failure(.codeError))
                print("CODE: \(response.statusCode)")
                return
            }
            
            if let error = error {
                completion(.failure(.otherError))
                print("ERROR in Sesh: \(error)")
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                print("BAD DATA")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedPokemon = try decoder.decode(Pokemon.self, from: data)
                //self.pokemonArray.append(decodedPokemon)
                print("pokemon decoded: \(decodedPokemon)")
                completion(.success(decodedPokemon))
            } catch {
                print("DECODE error: \(error)")
                completion(.failure(.noDecode))
                return
            }
            print("ARRAY NOW: \(self.pokemonArray)")
            
        }.resume()
        
    }
}
