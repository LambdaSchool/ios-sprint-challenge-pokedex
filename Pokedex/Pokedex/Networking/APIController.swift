//
//  APIController.swift
//  Pokedex
//
//  Created by Chad Parker on 3/20/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case otherError(Error)
    case noData
    case decodeFailed
}

class APIController {
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
    
    func getPokemon(_ query: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        var request = URLRequest(url: baseUrl.appendingPathComponent("pokemon/\(query)"))
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodeFailed))
            }
        }
    }
}
