//
//  PokemonController.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethods: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badData
    case otherError
    case noDecode
    case notFound
    case badUrl
    case badImage
    
}


class PokemonController {
    var pokemen: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let lowercasedName = name.lowercased()
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(lowercasedName)")
                
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethods.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Network error response from URLSession \(error)")
                completion(.failure(.otherError))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Response Code not 200: \(response.statusCode)")
                completion(.failure(.notFound))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from API")
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error Decoding Pokemon: \(error)")
                completion(.failure(.noDecode))
                return
            }
            
            
        }.resume()
        
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethods.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.badImage))
                return
            }
            
            completion(.success(image))
            
        }.resume()
        
    }
    
    
    
}
