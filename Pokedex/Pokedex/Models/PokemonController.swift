//
//  PokemonController.swift
//  Pokedex
//
//  Created by Matthew Martindale on 3/22/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError(Error)
    case noData
    case decodeFailure
}

class PokemonController {
    
    var pokemonArray: [Pokemon] = []
    
    let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func searchPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonName.lowercased())
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodeFailure))
            }
        }.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
        let savedPokemon = Pokemon(name: pokemon.name, id: pokemon.id, types: pokemon.types, abilities: pokemon.abilities, sprites: pokemon.sprites)
        pokemonArray.append(savedPokemon)
    }
}
