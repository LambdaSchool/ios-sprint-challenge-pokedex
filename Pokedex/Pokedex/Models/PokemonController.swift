//
//  PokemonController.swift
//  Pokedex
//
//  Created by Mark Gerrior on 3/13/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation
import UIKit // For image fetching

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
    
    /// Fetch a Pokemon
    /// - Parameters:
    ///   - name: The name or id (as a string) of the Pokemon to find.
    ///   - completion: Use the new Swift Result to get the results of this call.
    func findPokemon(named name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let apiUrl = baseUrl.appendingPathComponent("pokemon/\(name)")
        
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
    }
    
    
    /// Grab an image from a URL
    /// - Parameters:
    ///   - urlString: Fully qualified URL to image
    ///   - completion: Use the new Swift Result to get the results of this call.
    func fetchImage(for urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let imageUrl = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving image data: \(error)")
                completion(.failure(.otherNetworkError))
                return
            }
            
            guard let data = data else {
                NSLog("Website responded with no image data.")
                completion(.failure(.badData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                NSLog("Image data is incomplete or corrupt.")
                completion(.failure(.badData))
                return
            }

            completion(.success(image))

        }.resume()
    }}
