//
//  PokemonController.swift
//  Pokedex
//
//  Created by Wyatt Harrell on 3/13/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case generic
    case statusCode
    case noData
    case decodeError
}

enum HTTPMethod: String {
    case get = "GET"
}

class PokemonController {

    var pokedex: [Pokemon] = []

    let baseUrl = URL(string: "https://pokeapi.co/api/v2")!
    
    func searchPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let searchUrl = baseUrl.appendingPathComponent("pokemon/\(searchTerm)")
        var request = URLRequest(url: searchUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("\(error)")
                completion(.failure(.generic))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Response Status Code: \(response.statusCode)")
                completion(.failure(.statusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
                
            } catch {
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
}
