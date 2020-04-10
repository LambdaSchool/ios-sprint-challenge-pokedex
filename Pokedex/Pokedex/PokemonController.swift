//
//  PokemonController.swift
//  Pokedex
//
//  Created by Hunter Oppel on 4/10/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation
import UIKit

final class PokemonController {
    
    // MARK: Properties
    typealias GetPokemonCompletion = Result<Pokemon, NetworkError>
    typealias GetImageCompletion = Result<UIImage, NetworkError>
    let pidgey = "pidgey"
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    enum NetworkError: Error {
        case failedFetch, badURL, badData
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Fetch Method
    
    func fetchPokemonWith(searchTerm: String, completion: @escaping (GetPokemonCompletion) -> Void) {
        let cleanedPokemon = searchTerm.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let requestURL = baseURL.appendingPathComponent(cleanedPokemon)
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("Error fetching pokemon with search term \(searchTerm): \(error)")
                completion(.failure(.failedFetch))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            do {
//                dump(data)
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try self.decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding data to type Pokemon: \(error)")
                completion(.failure(.badData))
            }
        }
        .resume()
    }
    
    func fetchPokemonSprite(spriteURLString: String, completion: @escaping (GetImageCompletion) -> Void) {
        guard let spriteURL = URL(string: spriteURLString) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: spriteURL) { data, response, error in
            if let error = error {
                print("Failed to fetch pokemon sprite with error: \(error.localizedDescription)")
                completion(.failure(.failedFetch))
            }
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    print("Fetch image gave bad response")
                    return completion(.failure(.failedFetch))
            }
            guard let data = data,
                let sprite = UIImage(data: data)
                else {
                    print("Could not convert data into sprite")
                    return completion(.failure(.badData))
            }
            
            completion(.success(sprite))
        }
        .resume()
    }
    
//    func getPokemon(pokemon: String, completion: @escaping (GetPokemonCompletion) -> Void) {
//        let pokemonURL = baseURL.appendingPathComponent(pokemon)
//        print(pokemonURL)
////        let request = URLRequest(url: pokemonURL)
//
//        URLSession.shared.dataTask(with: pokemonURL) { data, response, error in
//            if let error = error {
//                print("Fetch pokemon failed with error: \(error.localizedDescription)")
//                completion(.failure(.failedFetch))
//            }
//            guard let response = response as? HTTPURLResponse,
//                response.statusCode == 200
//                else {
//                    print("Fetch pokemon returned bad response")
//                    return completion(.failure(.failedFetch))
//            }
//            guard let data = data else {
//                print("Data returned was nil")
//                return completion(.failure(.badData))
//            }
//
//            do {
//                dump(data)
//                let pokemon = try self.decoder.decode(Pokemon.self, from: data)
//                completion(.success(pokemon))
//            } catch {
//                print("Failed decoding pokemon: \(error.localizedDescription)")
//                completion(.failure(.failedFetch))
//            }
//        }
//        .resume()
//    }
    
    // MARK: - Helper Methods
    

    
    // MARK: Test Method
    
//    func testAPI () {
//        getPokemon(for: pidgey) { result in
//            switch result {
//            case .success(let pokemon):
//                print(pokemon)
//            case .failure(_):
//                print("Something went wrong")
//            }
//        }
//    }
}
