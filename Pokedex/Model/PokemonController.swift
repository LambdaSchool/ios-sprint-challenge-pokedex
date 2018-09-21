//
//  PokemonController.swift
//  Pokedex
//
//  Created by Madison Waters on 9/21/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    
    private (set) var pokedex: [Pokemon] = []
    
    private enum HTTPMethod: String {
        case GET = "GET"
        case PUT = "PUT"
        case POST = "POST"
        case DELETE = "DELETE"
        
    }
    //
    func searchForPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        print(requestURL)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                print("one")
                completion(nil, error)
                print("two")
                return
            }
            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                print("three")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(PokemonSearchResults.self, from: data)
                let pokedex = searchResults.pokemonResults
                completion(pokedex, nil)
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                print(data)
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
}

