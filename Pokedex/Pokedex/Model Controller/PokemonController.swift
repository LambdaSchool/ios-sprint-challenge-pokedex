//
//  PokemonController.swift
//  Pokedex
//
//  Created by Keri Levesque on 2/14/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
enum NetworkError: Error {
    case badUrl
    case otherError
    case badData
    case badRequest
    case noDecode
    case noEncode
    case badImage
}
class PokemonController {
    
    //MARK: Properties
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemonArray = [Pokemon]()
    
    func createPokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
          }
    
    var pokemons: Pokemon?
 
    // MARK: Methods
    func fetchPokemon(for pokemonName: String, completion: @escaping(Result<Pokemon, NetworkError>) -> Void) {
        
       let pokemonUrl = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
       var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField:"Content-type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving pokemon name data: \(error)")
                completion(.failure(.otherError))
                return
            }
            if let response = response as? HTTPURLResponse, response.statusCode !=  200 {
                print(response.statusCode)
                NSLog("request URL is nil")
                completion(.failure(.badRequest))
                return
                 }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            let decoder = JSONDecoder()
            do {
                let pokemonNames = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonNames))
                self.pokemonArray.append(pokemonNames)
                self.pokemons = pokemonNames
                completion(.success(pokemonNames))
            } catch {
                NSLog("Error decoding pokemon objects: \(error.localizedDescription)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
        
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
           guard let imageUrl = URL(string: urlString) else {
               completion(.failure(.badUrl))
               return
           }
           
           var request = URLRequest(url: imageUrl)
           request.httpMethod = HTTPMethod.get.rawValue
           
           URLSession.shared.dataTask(with: request) { (data, _, error) in
               if let _ = error {
                   completion(.failure(.otherError))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(.badData))
                   return
               }
           
               guard let image = UIImage(data: data) else {
                   completion(.failure(.badImage))
                   return
               }
               
               completion(.success(image))
           }.resume()
       }
}
