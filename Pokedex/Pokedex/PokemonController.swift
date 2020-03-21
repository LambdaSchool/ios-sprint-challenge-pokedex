//
//  PokemonController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_241 on 3/20/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import Foundation

class PokemonController {
    
    enum HTTPMethod: String { // Use for any network request
          case get = "GET"
          case post = "POST"
         
      }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func searchForPokemonWith(searchTerm: String, completion: @escaping ([Pokemon])-> Void){
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Error: Request URL is nil")
            completion([Pokemon]())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) {(data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error!)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from data task")
                completion([])
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonSearch = try jsonDecoder.decode(PokemonSearch.self, from: data)
                completion(pokemonSearch.results)
            } catch {
               print("Usable to decode data: \(error)")
                completion([])
            }
        }.resume()
        
        // fetchDetails and fetchAllAnimalsName
        
    }
    
}
