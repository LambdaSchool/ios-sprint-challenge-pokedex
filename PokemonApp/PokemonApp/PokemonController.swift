//
//  PokemonController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/17/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation

class PokemonController {

    var pokeDex: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    func create(pokemon: Pokemon) {
        pokeDex.append(pokemon)
    }

    func deletePokemon(pokemon: Pokemon) {

        guard let index = pokeDex.index(of: pokemon) else { return }
        pokeDex.remove(at: index)
    }

    func fetchPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {

        let url = baseURL.appendingPathComponent(searchTerm)
        let request = URLRequest(url: url)
        request.httpMethod == "GET"

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting data: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("Bad data for fetch pokemon")
                completion(nil, NSError())
                return
            }

            let decoder = JSONDecoder()

            do {
                let pokemon = decoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)

            } catch {
                NSLog("Error with decoding Pokemon")
                completion(nil, error)
                return
            }
        }.resume()
    }

    




}
