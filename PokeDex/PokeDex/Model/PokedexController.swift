//
//  PokedexController.swift
//  PokeDex
//
//  Created by David Williams on 5/16/20.
//  Copyright © 2020 david williams. All rights reserved.
//

import Foundation
import UIKit

class PokedexController {
    
    enum NewtworkError: Error {
        case nilValue
        case failure
        case failedFetch
        case noData
        case searchSuccessful
        case decodeFailure
    }
    
    
    
    enum HTTPMethod: String {
           case get = "GET"
    }
    
   // private let baseURL = URL(string: "https://lambdapokeapi.herokuapp.com/")!
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
   // func searchForPokemonWith(searchTerm: String, completion: @escaping ([Pokemon]) -> Void) {
    func searchForPokemonWith(searchTerm: String, completion: @escaping (Result<Pokemon, NewtworkError>) -> Void) {
          //var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        //  let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        let searchTermQueryItem = baseURL.appendingPathComponent(searchTerm.lowercased())
         // urlComponents?.queryItems = [searchTermQueryItem]
        //let searchTermQueryItem =   let requestURL = URLRequest(url: searchTermQueryItem)
          var request = URLRequest(url: searchTermQueryItem)
          request.httpMethod = HTTPMethod.get.rawValue
          
          URLSession.shared.dataTask(with: request) { (data, _, error) in
              guard error == nil else {
                  print("Error fetching data: \(error!)")
                completion(.failure(.failedFetch))
                  return
              }
              
              guard let data = data else {
                  print("Error: No data returned from data task.")
                completion(.failure(.noData))
                  return
              }
              
              let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
              do {
                  let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
              } catch {
                  print("Unable to decode search: \(error)")
                completion(.failure(.decodeFailure))
              }
          }.resume()
      }
    
    func savePokemon(with newPokemon: Pokemon) {
        
    }
    
    
    
    
}
