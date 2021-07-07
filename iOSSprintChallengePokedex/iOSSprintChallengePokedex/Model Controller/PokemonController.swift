//
//  PokemonController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/13/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
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

class PokemonController {
    
    
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    
    
    func addPokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
    
    // MARK: FetchPokemon
    
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let url = baseURL?.appendingPathComponent(name.lowercased())
        guard let apiURL = url else { return }
        var request = URLRequest(url: apiURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(.failure(.badData))
                return
            }
            
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    // MARK: Fetch Sprite
    
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            
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
    
}

