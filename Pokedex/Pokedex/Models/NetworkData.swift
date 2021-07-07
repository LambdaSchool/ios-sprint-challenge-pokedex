//
//  NetworkData.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

class NetworkData {
    
    // MARK: Network data
    static let shared = NetworkData()
    private init() {}
    
    // Set the base URL
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    
    // Save the found Pokemon here
    var pokemonAPI: PokemonAPI?
    
    func searchForPokemon(with findThisPokemon: String, completion: @escaping ((Error?) -> Void)) {
        // Complete the URL for the pokemon
        guard let pokemonURL = baseURL?.appendingPathComponent(findThisPokemon) else {
            NSLog("Unable to construct URL")
            completion(NSError())
            return
        }
        var searchRequest = URLRequest(url: pokemonURL)
        searchRequest.httpMethod = "GET"
        
        // Create the URLSession and search for the Pokemon
        URLSession.shared.dataTask(with: pokemonURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(error)
                return
            }
            
            // Check for data returned by the dataTask
            guard let data = data else {
                NSLog("Request did not return valid data")
                completion(error)
                return
            }
            
            // We have data, decode it and store it
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                NetworkData.shared.pokemonAPI = try jsonDecoder.decode(PokemonAPI.self, from: data)
                completion(nil)
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
                return
            }
        } .resume() //End of URLSession
    } // End of searchForPokemon

} // End of class
