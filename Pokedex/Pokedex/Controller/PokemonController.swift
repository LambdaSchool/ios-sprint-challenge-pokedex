//
//  PokemonController.swift
//  Pokedex
//
//  Created by Dahna on 4/10/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

class PokemonController {
    
    enum HTTPmethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData, badData, badEncode, failedFetch, badURL
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    
    
    func searchPokemon(searchTerm: String, completion: @escaping (NetworkError?) -> Void) {
        
        let queryTerm = searchTerm.lowercased()
        let url = baseURL.appendingPathComponent(queryTerm)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPmethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let self = self else { return }
            
            guard let data = data else {
                print("No data returned from dataTask")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let pokemonSearch = try jsonDecoder.decode(PokemonSearch.self, from: data)
                self.pokemon = pokemonSearch.results
            } catch {
                print
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
