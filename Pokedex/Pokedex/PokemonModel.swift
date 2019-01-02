//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 1/1/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation

class PokemonModel {
    
static let shared = PokemonModel()
    private init() {}
    
    var pokemons: [Pokemon] = []
    var pokemon: Pokemon?
    
    var numberOfPokemon: Int {
        return pokemons.count
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return pokemons[indexPath.row]
    }

    func addPokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func deletePokemon(at indexPath: IndexPath) {
        pokemons.remove(at: indexPath.row)
    }
    
    func savePokemon(pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        pokemons.append(pokemon)
    }

    static let endpoint = "https://pokeapi.co/api/v2/pokemon/"
    
    func search(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        guard let baseURL = URL(string: PokemonModel.endpoint)
            else { fatalError("unable to construct baseURL") }
        let searchResultURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        URLSession.shared.dataTask(with: searchResultURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Could not get data.")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                PokemonModel.shared.pokemon = pokemon
                completion(pokemon, nil)
                return
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
