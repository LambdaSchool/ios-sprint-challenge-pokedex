//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jessie Ann Griffin on 9/15/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")
    var pokemon: Pokemon?
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let baseURL = baseURL else {
            completion(.failure(.otherError))
            return
        }
        
        let pokemonUrl = baseURL.appendingPathComponent("pokemon/\(searchTerm)")
        
        var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.otherError))
            }
            
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("No data returned from task.")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                //self.pokemon = pokemonSearch.result
                completion(.success(pokemon))
            } catch {
                print("Unable to decode data into a Pokemon object: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageUrl = URL(string:urlString)!
        
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
