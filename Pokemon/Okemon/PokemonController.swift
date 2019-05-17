//
//  PokemonController.swift
//  Okemon
//
//  Created by Jonathan Ferrer on 5/17/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

import UIKit

class PokemonController {

    var pokemons: [Pokemon] = []
    var pokemon: Pokemon?

    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!


    func addPokemon(name: String, id: Int, abilities: [Ability], types: [Types], sprites: Sprite) {
        let pokemon = Pokemon(name: name, id: id, abilities: abilities, types: types, sprites: sprites)

        pokemons.append(pokemon)

    }

    func getImage(image: String, completion: @escaping (UIImage?, Error?) -> Void) {

        let imageURL = URL(string: image)!

        var requestURL = URLRequest(url: imageURL)
        requestURL.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in

            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError())
                return
            }

            let image = UIImage(data: data)!
            completion(image, nil)
            }.resume()
    }


    func searchPokemon(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        let requestURL = PokemonController.baseURL.appendingPathComponent(searchTerm.lowercased())

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
