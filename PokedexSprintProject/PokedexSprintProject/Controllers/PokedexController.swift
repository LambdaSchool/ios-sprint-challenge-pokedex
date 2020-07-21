//
//  PokemonController.swift
//  PokedexSprintProject
//
//  Created by BrysonSaclausa on 7/18/20.
//  Copyright © 2020 Lambda. All rights reserved.
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
    var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var pokemonResults : [Pokemon] = []
    
    func searchForPokemon(_ searchText: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let searchURL = baseURL.appendingPathComponent(searchText.lowercased())
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //Handle Error
            if let error = error {
                print("Error \(error)")
                completion(.failure(.noData))
            }
            
            //Handle Response
            if let response = response as? HTTPURLResponse {
                print("Response error: \(response)")
                completion(.failure(.noData))
                return
            }
            
            //Handle Data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
//            let jsonDecoder = JSONDecoder()
            
            do {
                let pokemonResult = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonResult))
            } catch {
                print("Unable to decode the pokemon \(searchText)")
                completion(.failure(.tryAgain))
            }
            } .resume()
 
    }
    
    
    
}

