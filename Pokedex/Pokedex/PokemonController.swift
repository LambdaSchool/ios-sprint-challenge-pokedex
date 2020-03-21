//
//  PokemonController.swift
//  Pokedex
//
//  Created by Morgan Smith on 3/20/20.
//  Copyright © 2020 Morgan Smith. All rights reserved.
//

import Foundation

class PokemonController {
    
       // MARK: -Properties
       private let baseURL = URL(string: "http://poke-api.vapor.cloud/api/v2/pokemon")!
       
       var pokemon: [Pokemon] = []
       
       enum HTTPMethod: String {
           case get = "GET"
           case put = "PUT"
           case post = "POST"
           case delete = "DELETE"
       }
       
       func searchPokemon(searchTerm: String, completion: @escaping () -> Void) {
           var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
           let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
           urlComponents?.queryItems = [searchTermQueryItem]
           
           guard let requestURL = urlComponents?.url else {
               print("Error: Request URL is nil!")
               completion()
               return
           }
           
           var request = URLRequest(url: requestURL)
           request.httpMethod = HTTPMethod.get.rawValue
           
           URLSession.shared.dataTask(with: request) { (data, _, error) in
               guard error == nil else {
                   print("Error fetching data: \(error!)")
                   completion()
                   return
               }
               
               guard let data = data else {
                   print("Error: no data returned from data task")
                   completion()
                   return
               }
               
               let jsonDecoder = JSONDecoder()
               
               do {
                   let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = [pokemonSearch]
               } catch {
                   print("Unable to decode data into object of type [Pokemon]: \(error)")
               }
               completion()
           }.resume()
       }
   }

