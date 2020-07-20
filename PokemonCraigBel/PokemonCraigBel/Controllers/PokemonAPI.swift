//
//  PokemonAPI.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
        // case post = "POST"
    }
    
    enum NetworkError: Error {
        case noData
        case noToken
        case tryAgain
    }
    
    var bearer: Bearer?
    
    private let baseURL = URL(string: "https://lambdapokeapi.herokuapp.com/api")!
    private lazy var pokemonSearchURL = baseURL.appendingPathComponent("/v2/pokemon/")
    
    func searchPokemon(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        var request = URLRequest(url: pokemonSearchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print ("\(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemonNames = try JSONDecoder().decode([String].self, from: data)
                completion(.success(pokemonNames))
            } catch {
                print("Error \(error)")
                completion(.failure(.tryAgain))
            }
            
        }
        task.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
           let imageURL = URL(string: urlString)!
           
           var request = URLRequest(url: imageURL)
           request.httpMethod = HTTPMethod.get.rawValue
           
           let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
               if let error = error {
                   print("Error: \(error)")
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
