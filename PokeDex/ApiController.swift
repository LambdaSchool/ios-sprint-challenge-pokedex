//
//  pokeApi.swift
//  PokeDex
//
//  Created by Nicolas Rios on 11/26/19.
//  Copyright © 2019 Nicolas Rios. All rights reserved.
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

 class PokeAPIController {

    
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")

     // MARK: PokemonSearch
    
        func fetchPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
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
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
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

     // MARK: - Pokemon Functions

        func addPokemon(pokemon: Pokemon) {
            pokemonArray.append(pokemon)
        }

         func delete(pokemon: Pokemon) {
            guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
            pokemonArray.remove(at: index)
        }

 }
