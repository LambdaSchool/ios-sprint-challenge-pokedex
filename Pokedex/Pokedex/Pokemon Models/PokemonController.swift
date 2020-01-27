//
//  PokemonController.swift
//  Pokedex
//
//  Created by Alex Thompson on 11/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

enum NetWorkError: Error {
    case otherError
    case badData
    case noDecode
    case noData
}

class PokemonController {
    var pokemonList: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    func fetchPokemon(pokemonName: String, completion: @escaping ((Result<Pokemon, Error>) -> Void)) {
        let pokemonUrl = baseURL?.appendingPathComponent(pokemonName.lowercased())
        guard let pokeUrl = pokemonUrl else { return }
        var request = URLRequest(url: pokeUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
            }
        }.resume()
    }
    
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { imageData, _, error in
            if let error = error {
                NSLog("Error fetching image: \(error)")
                return
            }
            
            guard let data = imageData else {
                NSLog("No data provided for image: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
        }.resume()
    }
    
    func addPokemon(pokemon: Pokemon) {
        pokemonList.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokemonList.firstIndex(of: pokemon) else { return }
        pokemonList.remove(at: index)
    }
}
