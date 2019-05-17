//
//  PokemonController.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import Foundation

class PokemonController {

    var pokemons: [Pokemon] = []
    var pokemon: Pokemon?

    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!


    func addPokemon(name: String, id: Int, abilities: [Ability], types: [Types], sprites: [Sprite]) {
        let pokemon = Pokemon(name: name, id: id, abilities: abilities, types: types, sprites: sprites)
        
        pokemons.append(pokemon)

    }


    func searchPokemon(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        let requestURL = PokemonController.baseURL.appendingPathComponent("pokemon/\(searchTerm)")

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from dataTask")
                completion(error)
                return
            }

            let decoder = JSONDecoder()
            do {

                let pokemonSearch = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemonSearch
                completion(nil)

            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(error)
            }
        }.resume()



    }




    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
}
