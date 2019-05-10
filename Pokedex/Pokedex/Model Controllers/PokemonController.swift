//
//  PokemonController.swift
//  Pokedex
//
//  Created by Alex on 5/10/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var myPokemon: [Pokemon] = []
    
    func createPokemon(pokemon: Pokemon) {
        myPokemon.append(pokemon)
    }
    
    func removePokemon(pokemon: Pokemon) {
        guard let currentIndex = myPokemon.index(of: pokemon) else { return }
        myPokemon.remove(at: currentIndex)
    }
    
    // MARK: - Search
    
    func performSearch(searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        // 1. build base URL to use
        var url = baseURL.appendingPathComponent("pokemon").appendingPathComponent(searchTerm.lowercased())
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return completion(nil, error)
            }
            
            // if we get data
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let results = try decoder.decode(Pokemon.self, from: data)
                    let pokemon = results
                    completion(pokemon, nil)
                } catch {
                    NSLog("Error decoding data.")
                    completion(nil, error)
                    return
                }
            }
        }
        .resume()
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let imageUrl = URL(string: url)!
        var urlRequest = URLRequest(url: imageUrl)
        urlRequest.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                print("There was an issue getting image.")
                return completion(nil, error)
            }
            
            let image = UIImage(data: data)!
            completion(image, nil)
        }
        .resume()
    }
}
