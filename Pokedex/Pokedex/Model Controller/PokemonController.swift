//
//  PokemonController.swift
//  Pokedex
//
//  Created by Moses Robinson on 1/25/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    
    func searchForPokemon(searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let url = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("error getting data: \(error)")
                completion(nil, error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let decodedData = try jsonDecoder.decode(Pokemon.self, from: data)
                    let pokemon = decodedData
                    completion(pokemon, nil)
                } catch {
                    NSLog("error decoding data")
                    completion(nil, error)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    func createPokemon(pokemon: Pokemon) {
        let pokemon = pokemon
        pokedex.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        pokedex.remove(at: index)
    }
    
    func fetchImage(for pokemon: Pokemon, completion: @escaping (Data?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: pokemon.sprites.frontDefault) { (data, _, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    private(set) var pokedex: [Pokemon] = []
}
