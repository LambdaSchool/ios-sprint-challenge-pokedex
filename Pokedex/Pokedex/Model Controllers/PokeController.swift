//
//  PokeController.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import Foundation

class PokeController {
    var addedPokemon = [Pokemon]()
    var currentPokemon: Pokemon?
    
    func savePokemon() {
        guard let currentPokemon = currentPokemon else { return }
        addedPokemon.append(currentPokemon)
    }
    
    // MARK: - Networking
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func catchPokemon(name: String, completion: @escaping (NetworkError?) -> Void) {
        
        let pokeURL = baseURL.appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.badAuth)
                return
            }
            
            if let _ = error {
                completion(.otherError)
                return
            }
            
            guard let data = data else {
                completion(.badData)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.currentPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(nil)
            } catch {
                print("Error decoding object: \(error)")
                completion(.noDecode)
                return
            }
        }.resume()
    }
}

// MARK: - Enums
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

