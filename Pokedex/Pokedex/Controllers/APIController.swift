//
//  APIController.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

class APIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    var pokemon: [Pokemon] = []
    
    func searchForPokemonWith(searchTerm: String, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL doesn't exist.")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned.")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokeSearch = try jsonDecoder.decode(PokeSearch.self, from: data)
                self.pokemon.append(contentsOf: pokeSearch.results)
            } catch {
                print("Unable to retrueve Pokemon: \(error)")
            }
            completion()
        }
        task.resume()
    }
}
