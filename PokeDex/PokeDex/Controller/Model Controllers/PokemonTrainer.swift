//
//  PokemonTrainer.swift
//  PokeDex
//
//  Created by Kenny on 1/17/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation
class PokemonTrainer {
    //MARK: Completion Handlers
    typealias CompletionHandlerWithError = (Error?) -> ()
    typealias CompletionHandlerWithPokemon = (Pokemon?) -> ()
    typealias CompletionHandlerWithPictureData = (Data?) -> ()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=964") //could get count and appendPathComponent dynamically if there's time
    var pokeDataArray: [PokemonData] = []
    var pokemon: [Pokemon] = []

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
    
    func getPokemonFromURL(url: URL?, completion: @escaping CompletionHandlerWithPokemon) {
        guard let url = url else {
            print("invalid URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            //Handle error
            if let error = error {
               NSLog("Error getting Pokemon \(error)")
               completion(nil)
               return
            }
            //Handle data
            guard let data = data else {
               NSLog("No data")
               completion(nil)
               return
            }
            do {
                let pokeData = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokeData)
            } catch {
                NSLog("Error decoding Pokemon: \(error)")
                completion(nil)
                return
            }
        }.resume()
    }
    
    func getPokemonPicture(url: URL?, completion: @escaping CompletionHandlerWithPictureData) {
        guard let url = url else {
            print("invalid URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error retrieving Picture Data: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("no data")
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }
    
    //MARK: Update
    func savePokemon(pokemon: Pokemon) {
        self.pokemon.append(pokemon) //shouldn't need to check conditionally since UI is disabled if pokemon is already saved
    }
    
    //MARK: Delete
    func removePokemon(pokemon: Pokemon) {
        self.pokemon.removeAll{
            if $0 == pokemon {
                print("removing \(pokemon)")
                return true
            }
            return false
        }
    }
}
