//
//  PokemonController.swift
//  Pokedex
//
//  Created by Kelson Hartle on 5/12/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import UIKit
import Foundation

class PokemonController {
    
    // MARK: - Enumerations
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    enum NetworkError: Error {
        case noData, failedSignUP, unableToCreateGig, failedSignIn, tryagain, noToken
    }
    
    // MARK: - Properties
    
    var pokemonArray: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    private lazy var jsonDecoder = JSONDecoder()
    
    // MARK: - Functions
    
    func getPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent(pokemonName.lowercased())
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("Error receiving pokemon data: \(error)")
                completion(.failure(.tryagain))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
            }
            guard let data = data else {
                print("No data received from getPokemon")
                completion(.failure(.noData))
                return
            }
            do {
                let pokemon = try self.jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding pokemon data: \(error)")
                completion(.failure(.tryagain))
            }
        }
        task.resume()
    }
    
    func getPokemonImage(at urlString: String, completion: @escaping (Result<UIImage,NetworkError>) -> Void) {
        let pokemonImageURL = URL(string: urlString)!
        var request = URLRequest(url: pokemonImageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error receiving pokemon image: \(pokemonImageURL), error: \(error)")
                completion(.failure(.noData))
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }
        task.resume()
    }
    
    func createPokemon(pokemon: Pokemon) {

        pokemonArray.append(pokemon)
    }
}
