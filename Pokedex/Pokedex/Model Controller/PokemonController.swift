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
enum NetworkError: Error {
    case noData, noDecode, badURL, incompleteData, tryAgain
}

class PokemonController {
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    
    // MARK: - FETCH POKEMON
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
<<<<<<< HEAD
        let pokemonURL = baseURL?.appendingPathComponent(name.uppercased())
        guard let pokemonsURL = pokemonURL else { return }
        var request = URLRequest(url: pokemonsURL)
        request.httpMethod = HTTPMethod.get.rawValue
=======
        let pokemonURL = baseURL.appendingPathComponent(name.lowercased())
>>>>>>> parent of f5d1f1e... So close to being done
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
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
                print("Unable to decode data into object of type [Pokemon]: \(error)")
            }
        } .resume()
        
<<<<<<< HEAD
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        //MARK: - CHANGE -- CHANGED DATA TO IMAGEDATA
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            if let error = error {
                
                print("Error grabbing image \(error)")
                return
            }
            guard let data = imageData else {
                print("no information given for image \(error)")
                completion(nil)
                return
=======
        
        // MARK: - FETCH IMAGE FUNCTION
        
        func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
            let imageURL = URL(string: urlString)!
            
            var request = URLRequest(url: imageURL)
            request.httpMethod = HTTPMethod.get.rawValue
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    print("Error fetching pokemon image: \(error)")
                    completion(.failure(.noData))
                    return
                }
                guard let data = data else {
                    print("No data provided for image: \(error)")
                    completion(.failure(.noData))
                    return
                }
                guard let image = UIImage(data: data) else {
                    print("Data for image is broken")
                    completion(.failure(.incompleteData))
                    return
                    
                }
                completion(.success(image))
                //TODO: .resume()
            }
            
            
            // MARK: ADD POKEMON
            func addPokemon(pokemon: Pokemon) {
                pokemonArray.append(pokemon)
            }
            // MARK: DELETE POKEMON
            func delete(pokemon: Pokemon) {
                guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
                pokemonArray.remove(at: index)
>>>>>>> parent of f5d1f1e... So close to being done
            }
            
            
<<<<<<< HEAD
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
=======
            
            // MARK: - TODO: ADD PERSISTENCE
            
        }
>>>>>>> parent of f5d1f1e... So close to being done
    }
}
