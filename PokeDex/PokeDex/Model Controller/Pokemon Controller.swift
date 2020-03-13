//
//  Pokemon Controller.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case badUrl
}

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/name")!
    
    var pokemons: [Pokemon] = []
    var pokemon: Pokemon!
    
    func addPokemon(withName name: String, id: Int, ability: Abilities, types: String) {
        let pokemon = Pokemon(name: name, id: id, ability: [ability], types: types)
        pokemons.append(pokemon)
    }
    
       func pokemonSearch(searchTerm: String, completion: @escaping (Error?) -> Void) {
           var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
           let searchTermQueryItem = URLQueryItem(name: "name", value: searchTerm)
           urlComponents?.queryItems = [searchTermQueryItem]
           guard let requestURL = urlComponents?.url else {
               NSLog("request URL is nil")
               return
           
        }
//        let pokemonNameURL = baseURL.appendingPathComponent("\(pokemon.name)")
           var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
           
           URLSession.shared.dataTask(with: request) { (data, _, error) in
               if let error = error {
                   NSLog("Error fetching data: \(error)")
                completion(error)
                   return
               }
               
               guard let data = data else {
                completion(error)
                   return
               }
               
               let jsonDecoder = JSONDecoder()
               do {
                   let pokemonSearch = try jsonDecoder.decode(PokemonSearchResults.self, from: data)
                self.pokemons.append(contentsOf: pokemonSearch.results)
                   
               } catch {
                   NSLog("Unable to decode data into object of type [Pokemon]: \(error)")
                completion(error)
               }
         }.resume()
       }
    
    
}

