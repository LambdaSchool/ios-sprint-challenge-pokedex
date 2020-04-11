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
    case delete = "DELETE"
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
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(name)")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
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
    
    func fetchImage(with imageURL: String, completion: @escaping (UIImage?) -> Void){
        
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            if let error = error {
                print("Error fetching image: \(error)")
                return
            }
            
            guard let data = imageData else {
                print("No data for image: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
        }.resume()
    }
    
    func save(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
}





