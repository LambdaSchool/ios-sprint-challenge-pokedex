//
//  APIController.swift
//  Pokedex
//
//  Created by Sal Amer on 1/24/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
//    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case decodingError
}

class APIController {
    
    var pokemonsArray: [Pokemon] = []
//    let pokemonImages: [URL] = []
     let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
//    let baseUrl = URL(string: "http://poke-api.vapor.cloud/")!

    // create function for fetching all pokemon
    
    func fetchAllPokemon(named pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let requestURL = baseUrl
        .appendingPathComponent("pokemon")
        .appendingPathComponent(pokemonName.lowercased())
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            guard error == nil else {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
               
            let decoder = JSONDecoder()
            do {
                let pokemonRetrieved = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonRetrieved))
            } catch {
                print("unable to decode data into object type Pokemon: \(error)")
                completion(.failure(.decodingError))
            }
        } .resume()
    }
    
    
    // create function to fetch image
    
    func fetchImage(for imageURL: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageUrl = URL(string: imageURL ) else {
            completion(.failure(.otherError))
            return
        }
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in
        guard error == nil else {
            completion(.failure(.otherError))
            return
        }

        guard let data = data else {
            completion(.failure(.badData))
            return
        }

        guard let image = UIImage(data: data) else {
            return
        }
            
        completion(.success(image))

    } .resume()

}
    func addPokemon(pokemon: Pokemon) {
        pokemonsArray.append(pokemon)
    }

    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokemonsArray.firstIndex(of: pokemon) else { return }
        pokemonsArray.remove(at: index)
    }

 
}
