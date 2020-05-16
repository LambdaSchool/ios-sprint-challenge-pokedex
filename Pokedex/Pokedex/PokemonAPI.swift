//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation
import UIKit

final class PokemonAPI {
    
    
    
    enum HTTPMethod: String {
           case get = "GET"
           
       }
       
       enum NetworkError: Error {
           case noData, failedSignUp, failedSignIn, noToken, tryAgain, invalidURl
       }
    
   private let baseURL = URL(string: "https://pokeapi.co/api")!
    private lazy var pokemonURL = baseURL.appendingPathComponent("/v2/pokemon/")
    
    func getPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURLName = baseURL.appendingPathComponent(name)
        
        var request = URLRequest(url: pokemonURLName)
         request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                   if let error = error {
                       print("Error reciving animal data wiht \(error)")
                       completion(.failure(.tryAgain))
                       return
                   }
                   if let response = response as? HTTPURLResponse,
                       response.statusCode == 401 {
                       completion(.failure(.noToken))
                       return
                   }
                   guard let data = data else {
                       print("No data received from getAllAnimals")
                       completion(.failure(.noData))
                       return
                   }
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Erorr decoding pokemon with error: \(error)")
                completion(.failure(.tryAgain))
                return
            }
    }
        task.resume()
    
}
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
          let imageURL = URL(string: urlString)!
          
          var request = URLRequest(url: imageURL)
          request.httpMethod = HTTPMethod.get.rawValue
          
          let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
              if let error = error {
                  print("Error receiving pokemon image with error \(error)")
                  completion(.failure(.tryAgain))
                  return
              }
              
              guard let data = data else {
                  completion(.failure(.noData))
                  return
              }
              
              let image = UIImage(data: data)!
              completion(.success(image))
          }
          task.resume()
      }
}
