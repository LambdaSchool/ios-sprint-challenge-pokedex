//
//  PokemonController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/17/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {

    init() {
        loadFromPersistentStore()
    }

    var pokeDex: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    func create(pokemon: Pokemon) {
        pokeDex.append(pokemon)
        saveToPersistentStore()
    }

    func deletePokemon(pokemon: Pokemon) {

        guard let index = pokeDex.index(of: pokemon) else { return }
        pokeDex.remove(at: index)
        saveToPersistentStore()
    }

    func fetchPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {

        let url = baseURL.appendingPathComponent(searchTerm)
        let request = URLRequest(url: url)


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
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)

            } catch {
                NSLog("Error with decoding Pokemon")
                completion(nil, error)
                return
            }
        }.resume()
    }

    func fetchImages(pokemon: Pokemon, completion: @escaping (UIImage?, Error?) -> Void) {

        let url = URL(string: pokemon.sprites.frontDefault)!
        let request = URLRequest(url: url)


        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Sprites: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("Bad data for images")
                completion(nil, NSError())
                return
            }

            let image = UIImage(data: data)
            completion(image, nil)
        }.resume()
    }



    private var persistentURL: URL? {
        let fileManager = FileManager.default
        guard let document = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }

        return document.appendingPathComponent("pokemon.plist")
    }



    private func saveToPersistentStore() {

      guard let url = persistentURL else { return }
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(pokeDex)
            try data.write(to: url)

        } catch {
            NSLog("Error encoding into the Persistent Store.")
            return
        }
    }


    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentURL, fileManager.fileExists(atPath: url.path) else { return }

        let decoder = PropertyListDecoder()

        do {
            let data = Data(contentsOf: url)
            let pokeDex = try decoder.decode([Pokemon].self, from: data)
            self.pokeDex = pokeDex

        } catch {
            NSLog("Error decoding saved data")
            return
        }
    }




}
