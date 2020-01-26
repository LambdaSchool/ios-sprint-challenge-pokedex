//
//  PokemonController.swift
//  ios-sprint-challenge-pokedex
//
//  Created by patelpra on 1/25/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//
import UIKit
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case badData
    case otherError
}

class PokemonController {
    
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "http://poke-api.vapor.cloud/api/v2")!
    
    func searchPokeman(searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let searchPokemanURL = baseURL.appendingPathComponent("pokemon/\(searchTerm.lowercased())")
        print(searchPokemanURL)
        
        var request = URLRequest(url: searchPokemanURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, result, error) in
            if let error = error {
                NSLog("Error fetching data \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(pokemonSearch, nil)
            } catch {
                NSLog("Unable to decode data object: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage,
        NetworkError>) -> Void) {
        let imageUrl = URL(string: urlString)!
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
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
    
    func savePokemon(with pokemon: Pokemon) {
        self.pokemon.append(pokemon)
    }
    
    func delete(with pokemon: Pokemon) {
        guard let index = self.pokemon.firstIndex(of: pokemon) else { return }
        self.pokemon.remove(at: index)
    }
}
