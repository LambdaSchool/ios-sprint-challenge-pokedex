//
//  PokemonController.swift
//  Pokedex
//
//  Created by Carolyn Lea on 8/10/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController
{
    var pokemons: [Pokemon] = []
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void)
    {
        
        let url = baseURL.appendingPathComponent(searchTerm)
        print("This is the searchQueryItem \(url)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error
            {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
            }

            guard let data = data else {
                NSLog("Error fetching data. No data returned")
                completion(nil, NSError())
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let searchResults = try jsonDecoder.decode(Pokemon.self, from: data)
                print(searchResults.name)
                print(searchResults.id)
                print(searchResults.abilities)
                print(searchResults.types)
                let pokemon = searchResults
                completion(pokemon, nil)
            } catch {
                NSLog("Unable to decode data into pokemon: \(error)")
                completion(nil, error)
                return
            }
        }

        dataTask.resume()
        
    }
    
    func createPokemon(name: String, id: Int, abilities: [Pokemon.Ability], types: [Pokemon.PokemonType]) -> Pokemon
    {
        let pokemon = Pokemon(name: name, id: id, abilities: abilities, types: types)
        pokemons.append(pokemon)
        return pokemon
    }
    
    func deletePokemon(pokemon: Pokemon, completion: @escaping (Error?) -> Void)
    {
        let url = baseURL.appendingPathComponent(pokemon.name)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("error \(error)")
                completion(error)
                return
            }
            DispatchQueue.main.async {
                guard let index = self.pokemons.index(of: pokemon) else {
                    completion(NSError())
                    return
                }
                self.pokemons.remove(at: index)
                completion(nil)
            }
        }.resume()
    }
}




// name: https://pokeapi.co/api/v2/pokemon/<NAME>
