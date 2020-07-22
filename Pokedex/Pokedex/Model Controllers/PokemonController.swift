//
//  PokemonController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 22/07/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import UIKit

class PokemonController {
    
    //MARK: - Properties
    let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    let capturedPokemon: [Pokemon] = []
    
    //MARK: - Public Functions
    func searchForPokemon(with name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        guard let url = baseUrl?.appendingPathComponent(name.lowercased()) else {
            print("Supplied URL for request is invalid.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error retrieving Pokemon from server: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemonResult = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonResult))
            } catch {
                print("Error decoding Pokemon data retrieved from server: \(error)")
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
    func getSprite(from url: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error retrieving sprite from server: \(error)")
                return
            }
            
            guard let data = data else {
                print("Sprite data was not retrieved from server: \(error)")
                completion(nil)
                return
            }
            
            //TODO: - Create UIImage object from retrieved data.
            let sprite = UIImage(data: data)
            completion(sprite)
            
        }.resume()
    }
    
}
