//
//  PokemonController.swift
//  Pokedex
//
//  Created by Angel Buenrostro on 1/25/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemon: Pokemon?
    var pokes: [Pokemon] = []
    
    func createPokemon(name: String, id: Int, abilities: [Ability], types: [Type], sprites: Dictionary<String, URL>) -> Pokemon {
        let pokemon = Pokemon(name: name, id: id, abilities: abilities, types: types, sprites: sprites)
        self.pokes.append(pokemon)
        return pokemon
    }
    
    func deletePokemon(index: Int){
        pokes.remove(at: index)
    }
    
    
    func searchPokemon(searchTerm: String, completion: @escaping(Error?) -> Void) {
        let queryTerm = searchTerm.lowercased()
        var url = baseURL.appendingPathComponent(queryTerm)
        //url = url.appendingPathExtension("json")  //TODO: May not need json appended
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Error. No pokemon data returned.")
                completion(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                print(data)
                let poke = try decoder.decode(Pokemon.self, from: data)
                print("This is inside searchPokemon func: poke name is: \(poke.name)")
                self.pokemon = poke
                print("This is inside searchPokemon func: poke name is: \(self.pokemon!.name)")
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    
}



