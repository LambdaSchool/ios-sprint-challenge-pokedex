//
//  PokemonController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/10/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {

     var pokemons: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
     var pokemon: Pokemon?


    func create(pokemon: Pokemon) {
        pokemons.append(pokemon)

    }

    func delete(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }


    func fetchPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {

        let url = baseURL.appendingPathComponent(searchTerm.lowercased())
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError())
                return
            }

            let decoder = JSONDecoder()


            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon


            } catch {
                NSLog("Error decoding Pokemon: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }

    func fetchImage(at urlSprite: Pokemon, completion: @escaping (UIImage?, Error?) -> Void) {

        let urlImage = URL(string: urlSprite.sprites.frontDefault)!

        var request = URLRequest(url: urlImage)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError())
                return
            }

            let image = UIImage(data: data)
            completion(image, nil)

        }.resume()
    }

}



