//
//  PokemonController.swift
//  pokedex sprint 3
//
//  Created by Rick Wolter on 11/1/19.
//  Copyright © 2019 Richar Wolter. All rights reserved.
//

import Foundation
import UIKit

let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
       
       private(set) var pokedex: [Pokemon] = []
    
    
    func search(searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let url = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Errror getting data: \(error)")
                completion(nil, error)
                return
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
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
    
    
    func fetchImage(url: URL, completion: @escaping (Data?) -> Void) {
        let url = url
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error finding data \(error)")
                completion(nil)
                return
            }
            
            if let data = data {
                completion(data)
                return
            }
        }
        dataTask.resume()
    }
    func createPokemon(pokemon: Pokemon) {
        let pokemon = pokemon
        pokedex.append(pokemon)
    }
    
    func deletePokemon(with name: Pokemon) {
        guard let index = pokedex.firstIndex(of: name) else { return }
        pokedex.remove(at: index)
    }
    
}
