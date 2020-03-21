//
//  APIController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case unauthorized
    case otherError(Error)
    case noData
    case decodeFailed
}

class APIController {
    // MARK: Properties
    var bearer: Bearer?

    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: Public Methods
    func fetchPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let allPokemonUrl = baseUrl.appendingPathComponent("/\(pokemonName)")
        
        var request = URLRequest(url: allPokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.unauthorized))
                return
            }
            
            guard error == nil else {
                completion(.failure(.otherError(error!)))
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
                completion(.failure(.decodeFailed))
            }
        }.resume()
    }
    
}
