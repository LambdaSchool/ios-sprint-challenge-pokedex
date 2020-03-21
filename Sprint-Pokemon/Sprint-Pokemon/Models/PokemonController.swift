//
//  PokemonController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import Foundation

class PokemonController {
    
    var pokemons: [Pokemon] = []
    
    private let baseURL = URL(string: "https:lambdapokeapi.herokuapp.com")!
    
    func performSearch(searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQuery = URLQueryItem(name: "term", value: searchTerm)
        urlComponents?.queryItems = [searchTermQuery]
        
        guard let requestURL = urlComponents?.url else {
            print("Error URL request is nil")
            completion(NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data \(error)")
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from data task")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemons.append(pokemon)
                self.pokemons = [pokemon]
            } catch {
                NSLog("Unable to decode data into object of type [Pokemon]: \(error)")
                completion(error)
            }
        }.resume()
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    
}
