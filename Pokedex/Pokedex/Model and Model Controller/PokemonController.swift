//
//  PokemonController.swift
//  Pokedex
//
//  Created by Andrew Liao on 8/10/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!

class PokemonController{
    
    func create(name: String, id: String, abilities: String, types: String) {
        let newPokemon = Pokemon(name: name, id: id, abilities: abilities, types: types)
    
        pokemons.append(newPokemon)
    }
    
    func create(newPokemon:Pokemon){
        pokemons.append(newPokemon)

    }
       
    func delete(index: Int){
        pokemons.remove(at: index)
    }
    
    func fetch(searchName: String, completion: @escaping (Pokemon?,Error?) -> Void){
        //create URL for dataTask
        let url = baseURL.appendingPathComponent(searchName.lowercased())

        
        //Create dataTask using URL since only getting
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            guard let data = data else {return}
            
            //TEST
            
            // Convert to a string and print
            print(url)
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                print("JSON: \(JSONString)")
            }

//            completion(Pokemon(name: "a", id: "b", abilities: "c", types: "d"),nil)
            //TEST
            
            //Decode data if data is not nil
            let decoder = JSONDecoder()
            do{
                //FIX: May not work. Can not use "Any" as value type since not decodable
                //However, we only need the values that can be converted to String so should be okay.
                let decoded = try decoder.decode(Pokemon.self, from: data)
                let name = decoded.name
                let id = decoded.id
                //FIX: need to add abilities and types. checking fetching first.

                let pokemon = Pokemon(name: name, id: id, abilities: "PLACEHOLDER", types: "PLACEHOLDER")
                completion(pokemon,nil)
            } catch {
                NSLog("Error Decoding: \(error)")
                completion(nil,error)
            }
            
        }.resume()

    }
    
    //MARK: - Properties
    private(set) var pokemons = [Pokemon]()
}
