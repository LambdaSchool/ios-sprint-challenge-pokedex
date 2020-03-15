//
//  PokemonController.swift
//  Pokedex 2
//
//  Created by Bhawnish Kumar on 3/14/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}
enum NetworkError: Error {
    case noDecoding
    case authError
    case otherError
}

class PokemonController {
    
    var pokemonList: [Pokemon] = []
    private let baseUrl = URL(fileURLWithPath: "https://pokeapi.co/api/v2")
    
    func fetchPokemon(with pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        
        var getPokemonUrl = baseUrl.appendingPathComponent("pokemon")
        getPokemonUrl.appendPathComponent(pokemonName)
        
        var request = URLRequest(url: getPokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error  in
            if let error = error {
                NSLog("Error in getting the request \(error)")
                completion(.failure(.otherError))
                
            }
            guard let data = data else {
                completion(.failure(.noDecoding))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                          let pokemon = try decoder.decode(Pokemon.self, from: data)
                          completion(.success(pokemon))
                      } catch {
                          print("Error decoding pokemon object: \(error)")
                        completion(.failure(.noDecoding))
                      }
        }.resume()
        
    }
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.authError))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.noDecoding))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
    
}
