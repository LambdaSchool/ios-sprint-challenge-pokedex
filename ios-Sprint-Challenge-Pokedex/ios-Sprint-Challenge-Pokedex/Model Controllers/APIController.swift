//
//  APIController.swift
//  ios-Sprint-Challenge-Pokedex
//
//  Created by Jonalynn Masters on 10/5/19.
//  Copyright © 2019 Jonalynn Masters. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case noData
}

class APIController {
    
    // MARK: Properties
    
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    // MARK: PokemonSearch
    
        func fetchPokemon(pokemonName: String, completion: @escaping (Pokemon?, Error?) -> Void) {
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
                print("No data returned from data task.")
                return
            }
            
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemonSearch, nil)
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
            }
        }.resume()
    }
    
    // MARK: Fetch Sprite
    
    func fetchImage(from imageURL: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {

        guard let imageURL = URL(string: imageURL) else { return }

        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (imageData, _, error) in

            if let error = error {
                completion(.failure(.otherError))
                NSLog("Error fetching image: \(error)")
                return
            }

            guard let data = imageData else {
                completion(.failure(.noData))
                NSLog("No data provided for image: \(imageURL)")
                return
            }
            completion(.success(data))
        }.resume()
    }
   
    // MARK: - Pokemon Functions

        func addPokemon(pokemon: Pokemon) {
            pokemonArray.append(pokemon)
        }

//        func delete(pokemon: Pokemon) {
//            guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
//            pokemonArray.remove(at: index)
//        }


  
    
}
