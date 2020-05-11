//
//  PokemonController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
enum NetworkError: Error {
    case noData, noDecode, badURL, incompleteData, tryAgain
}

class PokemonController {
    
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    
    // MARK: - FETCH POKEMON
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let pokemonURL = baseURL?.appendingPathComponent(name.lowercased())
        guard let pokemonsURL = pokemonURL else { return }
        var request = URLRequest(url: pokemonsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { data, respnse, error in
            if let error = error {
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                print(request.httpMethod)
                print(respnse)
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch let error {
                print(error)
                print("Unable to get decoded data: \(error)")
            }
        } .resume()
    }
        
        
        // MARK: - FETCH IMAGE FUNCTION
        
        func fetchImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
            guard let imageURL = URL(string: imageURL) else {
                completion(nil)
                return
            }
            
            var request = URLRequest(url: imageURL)
            request.httpMethod = HTTPMethod.get.rawValue
            
            URLSession.shared.dataTask(with: request) { (imageData, _, error) in
                if let error = error {
                    return
                }
                guard let data = imageData else {
                    completion(nil)
                    return
                }
                let image = UIImage(data: data)
                completion(image)
            } .resume()
        }
        
        
        // MARK: ADD POKEMON
        func addPokemon(pokemon: Pokemon) {
            pokemonArray.append(pokemon)
        }
        // MARK: DELETE POKEMON
        func delete(pokemon: Pokemon) {
            guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
            pokemonArray.remove(at: index)
            
            // MARK: - TODO: ADD PERSISTENCE
            
        }
        
    
}
