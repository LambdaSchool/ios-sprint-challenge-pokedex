//
//  PokemonController.swift
//  Pokedex
//
//  Created by Mark Gerrior on 3/13/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherNetworkError
    case badData
    case noDecode
    case badUrl
}

class PokemonController {

    // MARK: - Properites
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2")!
    private let backupBaseUrl = URL(string: "https://lambdapokeapi.herokuapp.com/")!
 
    var pokemon: [Pokemon] = []

    // MARK: - Methods
    
    // create function to fetch animal details
    func findPokemon(named name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let apiUrl = baseUrl.appendingPathComponent("ability/\(name)")
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving pokemon data: \(error)")
                completion(.failure(.otherNetworkError))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                // User is not authorize (no token or bad token)
                completion(.failure(.badAuth))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding \(name)")
                completion(.failure(.noDecode))
            }
            
        }.resume()
    }}
