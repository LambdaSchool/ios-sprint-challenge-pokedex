//
//  PokemonController.swift
//  PokeDex
//
//  Created by Enrique Gongora on 2/14/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badData
    case noDecode
    case otherError
    case noData
}

class PokemonController {
    
    //MARK: - Variables
    var pokemonList: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    //MARK: - Fetch Pokemon Function
    
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        // Create endpoint-specific URL
        let pokemonURL = baseURL.appendingPathComponent(name.lowercased())
        
        // Create a URL Request
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Set up data task and handle response
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error receiving pokemon data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            // Safely unwrap the data
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            // Decode the JSON
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    //MARK: - Fetch Image Function
    func fetchImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }
        
        //Create a URL Request
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Set up data task and handle response
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching pokemon data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.noDecode))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
}
