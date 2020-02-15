//
//  APIController.swift
//  PokeDex
//
//  Created by Chris Gonzales on 2/14/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import Foundation
import UIKit

class APIController{
    
    // MARK: - Properties
    
    private let baseURL = URL(string: APIKeys.baserURL)!
    
    // MARK: -Methods
    
    func searchForPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, APIErrors>) -> ()){
        
        let lowerCasedSearchTerm = searchTerm.lowercased()
        
        let urlString = ("\(baseURL)/\(lowerCasedSearchTerm)/")
        guard let requestURL = URL(string: urlString) else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethods.get.rawValue
        print("\(request)")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(.otherError))
                print("\(error)")
                NSLog("Error receiving Pokemon data: \(error)")
                return
            }
            guard let data = data else {
                print("bad data")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do{
                let newPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(newPokemon))
            } catch {
                print("\(error)")
            }
        }.resume()
    }
    
    func fetchSprite(pokemon: Pokemon, completion: @escaping (Result<UIImage?, APIErrors>) -> Void) {
        
        guard let requestURL = URL(string: pokemon.sprites.frontDefault) else {
            NSLog("Error creating URL")
            completion(.failure(.badURL))
            return
        }
        
//        var pokemonURL = baseURL.appendingPathComponent("pokemon")
//        pokemonURL.appendingPathComponent(search)
////
//        guard let imageURL = URL(string: urlString) else {
//            completion(.failure(.badURL))
//            return
//        }
//
//        var request = URLRequest(url: imageURL)
//        request.httpMethod = APIKeys.HTTPMethods.get.rawValue
//
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Pokemon Image: \(error)")
                completion(.failure(.otherError))
                return
            }
            guard let data = data else {
                NSLog("No data returned")
                completion(.failure(.badData))
                return
            }
            
             let image = UIImage(data: data)
            
        
            completion(.success(image))
            return
        }.resume()
    }
}
