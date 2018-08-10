//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jonathan T. Miles on 8/10/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class PokemonController {
    // READ
    var pokedex: [Pokemon] = []
    
    // CREATE
    func createPokemon(withName name: String, id: Int, abilities: [Pokemon.Ability], types: [Pokemon.PokemonType]) {
        let pokemon = Pokemon(name: name, id: id, abilities: abilities, types: types)
        pokedex.append(pokemon)
        // TODO: code for filling those categories with json data
    }
    
    // DELETE
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokedex.index(of: pokemon) else { return }
        pokedex.remove(at: index)
    }
    
    func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let baseURL = URL(string: "http://pokeapi.co/")!
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: "api/v2/pokemon/", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
            
        }
        
        let request = URLRequest(url: requestURL)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error GETting data from API: \(error)")
                completion(nil, error)
            }
            guard let data = data else {
                NSLog("Error; no data returned from GET")
                completion(nil, NSError())
                return
            }
            do {
                let searchResults = try JSONDecoder().decode(PokemonSearchResults.self, from: data)
                let pokedex = searchResults.results
                completion(pokedex, nil)
            } catch {
                NSLog("Unable to decode data from site into usable format")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
}
