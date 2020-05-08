//
//  PokemonResultsController.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

class PokemonResultsController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemons: [PokeResult] = []
    
    func performSearch(for pokemonName: String, completion: @escaping (Result<PokeResult, Error>) -> Void) {

            let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
            
            var request = URLRequest(url: pokemonURL)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Error fetching data: \(error)")
                    completion(.failure(NSError()))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError()))
                    return
                }

                let jsonDecoder = JSONDecoder()
                do {
                    let pokemonResult = try jsonDecoder.decode(PokeResult.self, from: data)
                    self.pokemons.append(pokemonResult)
                    completion(.success(pokemonResult))
                } catch {
                    completion(.failure(NSError()))
                }
            }.resume()
        }
    }

