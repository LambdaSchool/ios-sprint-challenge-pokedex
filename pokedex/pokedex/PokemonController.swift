//
//  PokemonController.swift
//  pokedex
//
//  Created by ronald huston jr on 5/8/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation
import UIKit

final class PokemonController {
    
    // MARK: - class properties
    typealias GetImageCompletion = Result<UIImage, NetworkError>
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    
    func fetchPokemon(pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent(pokemon)
        
        var request = URLRequest(url: pokemonURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            //  handle error if
            if let error = error {
                print("error fetching pokemon data: \(error)")
                completion(.failure(.fetchFail))
                return
            }
            //  handle data
            guard let data = data else {
                print("no data was returned from dataTask")
                completion(.failure(.noData))
                return
            }
            //  decode pokemon
            //  need to study if the result is appended into arrray
            do {
                let fetchRequest = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(fetchRequest))
                return
            } catch {
                print("unable to decode json into object: \(error)")
            }
        }.resume()
    }
    
    func fetchSprite(spriteURLString: String, completion: @escaping(GetImageCompletion) -> Void) {
        guard let spriteURL = URL(string: spriteURLString) else {
            return completion(.failure(.fetchFail))
        }
        
        URLSession.shared.dataTask(with: spriteURL) { data, response, error in
            if let error = error {
                print("failed to fetch pokemon sprite. error: \(error)")
                completion(.failure(.fetchFail))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    print("fetch image returned non-200 response")
                    completion(.failure(.fetchFail))
                    return
            }
            
            guard let data = data,
                let sprite = UIImage(data: data)
                else {
                    print("unable to render data as sprite")
                    completion(.failure(.badData))
                    return
            }
            completion(.success(sprite))
            
        }.resume()
    }
    
    
    func savePokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let place = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: place)
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case fetchFail
    case badData
    case noDecode
    case noData
}
