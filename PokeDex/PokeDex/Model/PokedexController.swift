//
//  PokedexController.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation
import UIKit

class PokedexController {
    
    enum NewtworkError: Error {
        case nilValue
        case failure
        case failedFetch
        case noData
        case searchSuccessful
        case decodeFailure
    }
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    var savedPokemon: [Pokemon] = [] {
        didSet {
            print(savedPokemon)
        }
    }
    
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func searchForPokemonWith(searchTerm: String, completion: @escaping (Result<Pokemon, NewtworkError>) -> Void) {
        let searchTermQueryItem = baseURL.appendingPathComponent(searchTerm.lowercased())
        
//        var request = URLRequest(url: searchTermQueryItem)
//        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: searchTermQueryItem) { (data, _, error) in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(.failedFetch))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode search: \(error)")
                completion(.failure(.decodeFailure))
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    func savePokemon(newPokemon: Pokemon) {
        savedPokemon.append(newPokemon)
    }
    
    func removeSavedPokemon(pokemon: Pokemon) {
        guard let index = savedPokemon.firstIndex(of: pokemon) else { return }
        savedPokemon.remove(at: index)
    }
}
