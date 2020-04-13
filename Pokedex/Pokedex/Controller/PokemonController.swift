//
//  PokemonController.swift
//  Pokedex
//
//  Created by Harmony Radley on 4/10/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badURL
    case badData
    case noDecode
    case failedFetch
}

class PokemonController {
    
    var pokemonArray: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func fetchPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("\(name.lowercased())")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.failedFetch))
                return
            }
            
            if let error = error {
                NSLog("Error getting request \(error)")
                completion(.failure(.failedFetch))
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
                print("Error decoding Pokemon objects: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchImage(with imageURL: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        let imageURL = URL(string: imageURL)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting request \(error)")
                completion(.failure(.failedFetch))
                return
            }
            
            guard let data = data else {
                print("No data for image: \(imageURL)")
                completion(.failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        } .resume()
    }
    
    func save(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
}





