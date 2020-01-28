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
    case post = "POST"
    case push = "PUSH"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case decodingError
    case noData
}

class APIController {
    
    var pokemonsArray: [Pokemon] = []
    let pokemonImages: [URL] = []
     let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")
//    let baseUrl = URL(string: "http://poke-api.vapor.cloud/")!

    // create function for fetching all pokemon
    
    func fetchAllPokemon(pokemonName: String, completion: @escaping ((Result<Pokemon, NetworkError>) -> Void)) {
        let pokemonURL = baseUrl?.appendingPathComponent(pokemonName.lowercased())
        guard let pokeURL = pokemonURL else { return }
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in

            guard error == nil else {
//                print("Error fetching data: \(error)")
                completion(.failure(.badData))
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
               
       
            do {
                let pokemonRetrieved = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonRetrieved))
            } catch {
                print("unable to decode data into object type Pokemon: \(error)")
            }
        } .resume()
    }
    
    
    // create function to fetch image
    
    func fetchImage(from imageURL: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = URL(string: imageURL ) else {
            completion(nil)
            return
        }
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
        guard error == nil else {
//            completion(.failure(.otherError))
            return
        }

        guard let data = imageData else {
            print("No data Pokemon Image data provided: \(imageURL)")
            completion(nil)
            return
        }

        let image = UIImage(data: data)
        completion(image)
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
