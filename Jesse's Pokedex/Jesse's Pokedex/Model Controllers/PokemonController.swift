//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jesse Ruiz on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkingError: Error {
    case noData
    case noBearer
    case serverError(Error)
    case unexpectedStatusCode
    case badDecode
    case badEncode
}

enum HeaderNames: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case applicationJSON = "application/json"
}

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    var savedPokemon: [Pokemon] = []
    
    func searchForPokemon(with searchedPokemon: String, completion: @escaping (Result<Pokemon, NetworkingError>) -> Void) {
        
        let pokemonURL = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(searchedPokemon.lowercased())
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching Pokemon: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from pokemon search")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemonSearch = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                NSLog("Unable to decode data into PokemonSearch: \(error)")
                completion(.failure(.badDecode))
            }
            }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> ()) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from image fetch data task")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
            }.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
    }
}
