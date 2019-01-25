//
//  PokedexAPI.swift
//  PokedexSprint3
//
//  Created by Jaspal on 1/25/19.
//  Copyright © 2019 Jaspal Suri. All rights reserved.
//

import UIKit

class PokemonSearchResultsController {
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    func performSearch(searchTerm: String, completion: @escaping (NSError?) -> Void) {
        
        let requestURL = URL(string: baseURL + searchTerm.lowercased())
        
        guard let searchRequestURL = requestURL
            else {
                NSLog("Could not make URL from components.")
                completion(NSError())
                return
            }
        
        var request = URLRequest(url: searchRequestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(NSError())
                return
            }
            
            do {
                let pokemonSearchResults = try JSONDecoder().decode(Pokemon.self, from: data)
                PokedexModel.shared.selectedPokemon = pokemonSearchResults
                completion(nil)
                return
                
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(NSError())
                return
            }
        }.resume()
    }
}

