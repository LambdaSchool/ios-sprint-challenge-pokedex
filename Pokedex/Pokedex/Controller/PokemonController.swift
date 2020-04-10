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
    
    var searchedPokemon: Pokemon?
    
    var pokemonList = [Pokemon]()
    
    func searchPokemon(searchTerm: String, completion: @escaping (NetworkError?) -> Void) {
        
        let queryTerm = searchTerm.lowercased()
        let url = baseURL.appendingPathComponent(queryTerm)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPmethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(.failedFetch)
                return
            }
            
            guard let data = data else {
                print("No data returned from dataTask")
                completion(.noData)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let fetchedPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.searchedPokemon = fetchedPokemon
                print(fetchedPokemon.name)
                completion(nil)
            } catch {
                print("No pokemon fetched")
                completion(.failedFetch)
                return
            }
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
}
