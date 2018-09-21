//
//  PokemonController.swift
//  Pokedex
//
//  Created by Iyin Raphael on 9/21/18.
//  Copyright © 2018 Iyin Raphael. All rights reserved.
//

import Foundation

let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!
class PokemonController {
    
    //MARK: - CRUD
    
    func create(pokemon: Pokemon){
        pokemons.append(pokemon)
    }
    
    func delete(pokemon: Pokemon){
        guard let index = pokemons.index(of: pokemon) else {return}
        pokemons.remove(at: index)
    }
    
    
    func fetchPokemon(name: String, completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathComponent(name.lowercased())
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error occured trying to fetch data from api: \(error)")
                completion(error)
                return
            }
            guard let data = data else {return}
            
            do{
                let dicodePoke = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemon = dicodePoke
            }catch{
                NSLog("error decoding: \(error)")
                return
            }
        }.resume()
        
    }

    
    var pokemons = [Pokemon]()
    var pokemon: Pokemon?
}
