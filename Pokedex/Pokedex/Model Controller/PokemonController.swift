//
//  PokemonController.swift
//  Pokedex
//
//  Created by Christopher Aronson on 5/10/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badResponse
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func search(for pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let url = baseUrl.appendingPathComponent(pokemon)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("Bad Response: \(response.statusCode)")
                completion(.failure(.badResponse))
                return
            }
            
            if let error = error {
                print("Error: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("Error with data")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let search = try decoder.decode(Pokemon.self, from: data)
                print(search)
                completion(.success(search))
            } catch {
                print("Error decoding: \(error)")
                completion(.failure(.noDecode))
                return
            }
            }.resume()
    }
    
    
}
