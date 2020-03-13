//
//  PokeController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_259 on 3/13/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError
    case noData
    case badData
}

class PokeController {
    
    // MARK: - Properties
    var pokemons: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    
    // MARK: - Methods
    func createPokemon(name: String, id: Int, abilities: [Ability], types: [Type], sprites: Sprite) {
        let pokemon = Pokemon(id: id, name: name, abilities: abilities, types: types, sprites: sprites)
        pokemons.append(pokemon)
        
    }
    
    func fetchPokemon(pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        
        let fetchPokemonURL = baseURL.appendingPathComponent("\(pokemon.lowercased())")
        
        var request = URLRequest(url: fetchPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving Pokemon data. \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data to decode")
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokeData = try decoder.decode(Pokemon.self, from: data)
                //self.pokemons.append(pokeData)
                completion(.success(pokeData))
            } catch {
                NSLog("Error decoding Pokemon object: \(error)")
                completion(.failure(.badData))
                return
            }
        }.resume()
    }
}
