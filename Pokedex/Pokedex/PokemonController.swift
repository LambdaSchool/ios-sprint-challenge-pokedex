//
//  PokemonController.swift
//  Pokedex
//
//  Created by Nathan Hedgeman on 8/9/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation

class PokemonController {
    
    //Enumerations
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "Delete"
        case put = "PUT"
    }
    
    enum NetworkError: Error {
        case noData
        case badAuth
        case noDecode
        case failedFetch(Error)
        case badURL
        case invalidData
    }
    
    //Properties
    
    var pokemon: Pokemon?
    var pokemonList: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
}



// MARK: Functions
extension PokemonController {
    
    func searchForPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName.lowercased())")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error reaching data from URL: \(error)")
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemonResult = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonResult))
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(.failure(.noData))
                return
            }
        }.resume()
    }
    
    func savePokemon() {
        
        guard let pokemon = pokemon else { return }
        
        pokemonList.append(pokemon)
    }
}
