//
//  PokemonController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 9/14/19.
//  Copyright © 2019 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit


enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badData
    case otherError
    case noDecode
}

class PokemonController {
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2")!
    
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonUrl = baseUrl.appendingPathComponent("pokemon/\(searchTerm)")
        
        
        var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let _ = error {
                completion(.failure(.otherError))
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
                print("Error decoding pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageUrl = URL(string: urlString)!
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
    
    
    
    
}


