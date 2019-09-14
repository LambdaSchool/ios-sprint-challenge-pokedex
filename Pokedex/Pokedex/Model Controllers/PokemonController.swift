//
//  PokemonController.swift
//  Pokedex
//
//  Created by John Kouris on 9/14/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var pokemon = [Pokemon]()
    
    func searchForPokemon(with searchTerm: String, completion: @escaping () -> Void) {
        
        guard let baseURL = baseURL else {
            completion()
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestUrl = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned from the data task.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonSearch = try jsonDecoder.decode(PokemonSearch.self, from: data)
                self.pokemon = pokemonSearch.results
            } catch {
                print("Unable to decode data into PersonSearch object: \(error.localizedDescription)")
            }
            completion()
            
        }.resume()
    }
    
}

