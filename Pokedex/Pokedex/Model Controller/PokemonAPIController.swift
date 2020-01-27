//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 27/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import Foundation

enum HTTPRequest: String {
    case GET
}

class PokemonAPIController {
    
    //API Properties
    let baseUrl: String = "https://pokeapi.co/api/v2/pokemon/"
    
    //Array to store results
    var searchResults: [Pokemon] = []
    
    func searchForPokemon(with name: String) {
        //Ensure that URL is valid
        guard let baseUrl = URL(string: baseUrl)?.appendingPathComponent(name) else {
            print("Error establishing URL for API call.")
            return
        }
        
        //Create URLRequest
        var request = URLRequest(url: baseUrl)
        request.httpMethod = HTTPRequest.GET.rawValue
        print(request)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Check for errors in API Call
            guard error == nil else {
                print("Error when contacting API: \(String(describing: error))")
                return
            }
            
            //Check to ensure data has been downloaded from API
            guard let data = data else {
                print("Error retrieving data from API: \(String(describing: error))")
                return
            }
            
            //Decode JSON Data
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.searchResults.append(pokemon)
            } catch {
                print("Error decoding data from API: \(error)")
            }
            
        }.resume()
        
    }
    
}
