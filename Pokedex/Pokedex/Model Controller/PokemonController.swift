//
//  PokemonController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 8/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class PokemonController {
    
    var pokemons: [Pokemon] = []
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func save(pokemon: Pokemon) {
        // add it to the array
        pokemons.append(pokemon)
        
        // sort array by id
        pokemons.sort { $0.id < $1.id }
    }
    
    func delete(pokemon: Pokemon) {
        // get the index, and remove it from the array
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    func fetchPokemon(withName name: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        let url = PokemonController.baseURL.appendingPathComponent(name.lowercased()).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving pokemon names from server: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                // There is only a dictionary being returned, so no need for an array
                let decodedPokemon = try JSONDecoder().decode(Pokemon.self, from: data)
//                let pokem
                DispatchQueue.main.async {
                    completion(decodedPokemon, nil)
                }
            } catch {
                NSLog("Unable to encode name: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving pokemon names from server: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image, nil)
            }
        }.resume()
    }
}
