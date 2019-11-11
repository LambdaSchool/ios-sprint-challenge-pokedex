//
//  PokemonController.swift
//  PokedexIOSPT3
//
//  Created by Jessie Ann Griffin on 11/10/19.
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
        
        let pokeURL = baseURL.appendingPathComponent("pokemon/\(searchTerm)")
        print(pokeURL)
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethods.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.otherError))
            }
            
            guard let data = data else {
                print("No data was returned from task.")
                completion(.failure(.badData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Unable to decode data into pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethods.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            }
        }.resume()
    }
}
