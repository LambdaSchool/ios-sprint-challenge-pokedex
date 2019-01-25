//
//  Model.swift
//  Pokedex
//
//  Created by Cameron Dunn on 1/25/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import Foundation

class Model{
    var savedPokemon : [Pokemon] = []
    
    
    func pokemonSearch(term searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void){
        var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        baseURL.appendPathComponent("\(searchTerm.lowercased())/")
        print(baseURL)
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error{
                print("There was an error while initializing the data task: \(error)")
                completion(nil, NSError())
                return
            }
            guard let data = data else{
                print("There was an error while retrieving the data from the API. No error was returned.")
                completion(nil, NSError())
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(Pokemon.self, from: data)
                let pokemonResults = results
                print(pokemonResults)
                completion(pokemonResults, error)
            }catch{
                print("Unable to complete decoding \(error)")
                completion(nil, NSError())
                return
            }
        }.resume()
    }
}
