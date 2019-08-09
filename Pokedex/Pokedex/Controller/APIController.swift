//
//  APIController.swift
//  Pokedex
//
//  Created by Bradley Yin on 8/9/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

class APIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    var pokemons: [Pokemon] = []
    
    enum HTTPMethod: String{
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func searchPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>)-> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon/\(name)")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error searching pokemon \(name): \(error)")
                completion(.failure(.otherError(error)))
                return
            }
            guard let data = data else {
                print("no return data on \(name)")
                completion(.failure(.noData))
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("error decoding pokemon \(name)")
                completion(.failure(.noDecode))
                return
            }
            
            
        }.resume()
    }
}
enum NetworkError: Error {
    case noToken
    case badURL
    case noData
    case noDecode
    case otherError(Error)
}
