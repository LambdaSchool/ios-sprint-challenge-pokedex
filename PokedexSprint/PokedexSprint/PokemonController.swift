//
//  PokemonController.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation

class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
    }

    enum NetworkError: Error {
        case noData
        case tryAgain
    }
    var baseURL = URL(string: "https://pokeapi.co/api/v2")!
    var pokemonResults : [PokemonSearchResult] = []
    
    func searchPokemonByName(searchText: String, completion: @escaping (Result<PokemonSearchResult, NetworkError>) -> Void) {
        
        let searchURL = baseURL.appendingPathComponent("pokemon/\(searchText)")
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //Handle Error
            if let error = error {
                print("Error \(error)")
                completion(.failure(.noData))
            }
            
            //Handle Response
            if let response = response {
                print("Response error")
                completion(.failure(.noData))
            }
            
            //Handle Data
            guard let data = data else {
                completion(.failure(.noData))
                return}
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let pokemonResult = try jsonDecoder.decode(PokemonSearchResult.self, from: data)
                completion(.success(pokemonResult))
            } catch {
                print("Unable to decode the pokemon \(searchText)")
                completion(.failure(.tryAgain))
            }
            } .resume()
 
    }
    
    
    
}

