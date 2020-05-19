//
//  APIController.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation

struct PokemonController: Decodable {
    
    var pokemonList: [Pokemon] = []
    
     // var crew: [Person] = []
    
    enum HTTPMethod: String {
        case get = "GET"
       
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    
    mutating func searchPokemon(searchTerm: String, completion: @escaping () -> Void ) {
        
        // Step 1: Build endpoint URL with query items
            var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("request URL is nil")
            completion()
            return
        }
        // Step 2: Create URL request
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // Step 3: Create URL task
        
        let task = URLSession.shared.dataTask(with: request) { [self] data, _, error in
            // Handle error first
            if let error = error {
                print("Error fetching data: \(error)")
                completion()
                return
            }
            
            // Handle Data Optionanlity
            guard let data = data else {
                print("no data returned from data task")
                completion()
                return
            }
            // Create Decoder
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            
            //Decode and adding objects to array
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon.append(contentsOf: pokemon.results)
            } catch {
                print("Unable to decode data into object of type person search: \(error)")
            }
            
            completion()
        }
        
        
        // Step 4: Run URL task
        task.resume()
    }
}
