//
//  PokemonController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

class PokemonController {
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    enum NetworkError: Error {
        case noData, noDecode, badURL, incompleteData, tryAgain
    }
    
    // MARK: - FETCH POKEMON
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURL = baseURL?.appendingPathComponent(name.lowercased())
        guard let pokemonsURL = pokemonURL else { return }
        var request = URLRequest(url: pokemonsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode data of [Pokemon]: \(error)")
            }
        } .resume()
    }
    
    
    // MARK: - FETCH IMAGE FUNCTION
    
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        //   (at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                
                print("Error grabbing image \(error)")
                return
            }
            guard let data = data else {
                print("no information given for image \(error)")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            
            completion(image)
            
        } .resume()
        
 
    }
    
    
    // MARK: ADD POKEMON
    func addPokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
    // MARK: DELETE POKEMON
    func delete(pokemon: Pokemon) {
        guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: index)
    }
    
    
    
    // MARK: - TODO: ADD PERSISTENCE
    
}


