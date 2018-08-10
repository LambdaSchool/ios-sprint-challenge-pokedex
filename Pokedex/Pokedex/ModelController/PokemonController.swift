//
//  PokemonController.swift
//  Pokedex
//
//  Created by Simon Elhoej Steinmejer on 10/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://pokeapi.co/api/v2/")!


class PokemonController
{
    private(set) var pokemons = [Pokemon]()
    
    func savePokemon(with pokemon: Pokemon)
    {
        pokemons.append(pokemon)
    }
    
    func deletePokemon(at index: Int)
    {
        pokemons.remove(at: index)
    }
    
    func searchPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> ())
    {
        let url = baseURL.appendingPathComponent("pokemon")
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let searchTermQueryItem = URLQueryItem(name: "name", value: searchTerm)
        urlComponents.queryItems = [searchTermQueryItem]
        
        guard let urlRequest = urlComponents.url else {
            NSLog("Failed to create url request from urlComponents")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error
            {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error unwrapping data: \(NSError())")
                completion(nil, NSError())
                return
            }
            
            do
            {
                let jsonDecoder = JSONDecoder()
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
                
            } catch {
            NSLog("Error decoding data")
            completion(nil, NSError())
            return
            }
        }.resume()
    }
}

































