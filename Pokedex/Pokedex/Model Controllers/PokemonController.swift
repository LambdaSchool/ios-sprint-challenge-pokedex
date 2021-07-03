//
//  PokemonController.swift
//  Pokedex
//
//  Created by Michael Stoffer on 6/1/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

import UIKit
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case otherError
    case badData
}

class PokemonController {
    private (set) var pokemons: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func searchForPokemon(searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(searchTerm.lowercased())")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, result, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else { NSLog("No data returned from data task"); completion(nil, error); return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding pokemon object: \(error)")
                completion(nil, error)
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
            
            guard let data = data else { completion(.failure(.badData)); return }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
    
    func savePokemon(with pokemon: Pokemon) {
        self.pokemons.append(pokemon)
    }
    
    func delete(with pokemon: Pokemon) {
        guard let index = self.pokemons.firstIndex(of: pokemon) else { return }
        self.pokemons.remove(at: index)        
    }
}
