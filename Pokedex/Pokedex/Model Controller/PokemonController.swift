//
//  PokemonController.swift
//  Pokedex
//
//  Created by Rick Wolter on 11/3/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    var pokemonArray = [Pokemon]()
    
    func performSearch(for name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(name)")

        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error during data retrieval: \(error)")
                completion(.failure(NSError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(NSError()))
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(.failure(NSError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NSError()))
            }
        }.resume()
    }
    
    func savePokemon(with pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
    
    func deletePokemon(_ pokemon: Pokemon) {
        guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: index)
    }
}
