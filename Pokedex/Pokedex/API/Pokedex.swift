//
//  PokedexController.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case otherError
    case notFound
    case badData
    case badUrl
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class Pokedex {
    var pokemon: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    // MARK: - Get pokemon
    func getPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        
        // MARK: - Build request URL
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // MARK: - Out into the world
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.otherError))
            }
            
            if let response = response as? HTTPURLResponse,
            response.statusCode != 200 {
                completion(.failure(.notFound))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            // MARK: - Unwrap data
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonData = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonData))
            } catch {
                NSLog("Couldn't decode pokemon data: \(error)")
            }
        }.resume()
        
    }
    
    // MARK: - Save Pokemon
    
    // MARK: - Convert image URL to Data
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let imageUrl = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving animal name data: \(error)")
                completion(.failure(.otherError))
            }
            
            
            guard let data = data else {
                NSLog("Github responded with no image data")
                completion(.failure(.badData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.badData))
                return
            }
            completion(.success(image))
        }.resume()
    }
}
