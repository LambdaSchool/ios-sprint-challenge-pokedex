//
//  PokedexController.swift
//  Pokemon
//
//  Created by Yvette Zhukovsky on 10/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class PokedexController {
    let baseURL = URL(string:"https://pokeapi.co/api/v2/")
    var pokemons:[Pokemon]=[]
    
    func fetchPokemon(name: String, completion: @escaping (Pokemon?, Error?) -> Void){
        let url = baseURL?
            .appendingPathComponent("pokemon")
            .appendingPathComponent(name.lowercased())
            .appendingPathComponent("")
        print(url!)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemin\(error)")
                completion(nil, error)
            }
            guard let data = data else {
                NSLog("Error fetching pokemon")
                completion(nil, error)
                return
            }
            
            var pokemon: Pokemon?
            do {
                pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            }
            catch{
                NSLog("Error decoding pokemon:\(error)")
                completion(nil, error)
                
            }
            if let spriteURL = pokemon?.sprites.filter({$0.value != nil}).randomElement()?.value {
                ImageLoader.fetchImage(from: URL(string:spriteURL)){ image in
                    pokemon?.image = image
                    completion(pokemon, nil)
                }
                
            }
        }
        dataTask.resume()
    }
    
    func savePokemons(pokemon:Pokemon){
        pokemons.append(pokemon)
    }
    
    
    func deletePokemon(at: Int) {
        pokemons.remove(at: at)
    }
}


