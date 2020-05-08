//
//  PokemonController.swift
//  Pokemon
//
//  Created by Cody Morley on 5/8/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

class PokemonController {
    //MARK: - Enums & Type Aliases -
    enum NetworkError: Error {
        case noData
        case badData
        case failedFetch
        case noDecode
    }
    
    enum HTTPRequests: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    //MARK: - Properties -
    var pokedex: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    
    //MARK: - Actions -
    func getPokemon(for text: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("pokemon/\(text.lowercased())")
        print(requestURL)
        
        var request = URLRequest(url: requestURL)
        
        request.httpMethod = HTTPRequests.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(.failedFetch))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("error in http response.")
                completion(.failure(.failedFetch))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return }
            
            do {
                let decoder = JSONDecoder()
                let newPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(newPokemon))
                
            } catch {
                print(error)
                completion(.failure(.noDecode))
            }
 
            }.resume()
    }
    
    
    func savePokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
}
