//
//  PokemonTrainer.swift
//  PokeDex
//
//  Created by Kenny on 1/17/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation
class PokemonTrainer {
    typealias CompletionHandlerWithError = (Error?) -> ()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var pokeDataArray: [PokemonData] = []

    func getPokemonData(completion: @escaping CompletionHandlerWithError) {
        guard let baseURL = baseURL else {return}
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            //Handle error
            if let error = error {
                NSLog("Error getting Pokemon \(error)")
                completion(error)
                return
            }
            //handle data
            guard let data = data else {
                NSLog("No data")
                completion(NSError())
                return
            }
            //decode Pokemon into array of pokemon to get by URL
            do {
                let pokemonData = try JSONDecoder().decode(PokemonDataResults.self, from: data)
                self.pokeDataArray = pokemonData.results
            } catch {
                NSLog("Error decoding Pokemon Data: \(error)")
                completion(error)
                return
            }
            //need to chain call to get pokemon?
            completion(nil)
        }.resume()
    }
    
    
}
