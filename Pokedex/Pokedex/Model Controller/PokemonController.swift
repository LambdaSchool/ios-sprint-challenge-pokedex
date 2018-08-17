//
//  PokemonController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 8/17/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    
    func create(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    func fetch(searchName: String, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(searchName.lowercased())

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }

            guard let data = data else {
                NSLog("Data was not recieved.")
                completion(error)
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let decodedPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = decodedPokemon
                completion(nil)
            }
            catch {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    var pokemons: [Pokemon] = []
    var pokemon: Pokemon?
    
}
