//
//  PokemonController.swift
//  Pokedex
//
//  Created by Ngozi Ojukwu on 8/17/18.
//  Copyright © 2018 iyin. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!

class PokemonController{
    
    
    
    func fetchPokemon(searchName: String, completion: @escaping (Pokemon?,Error?) -> Void){
        //create URL for dataTask
        let url = baseURL.appendingPathComponent(searchName.lowercased())
        
        
        //Create dataTask using URL since only getting
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            guard let data = data else {return}
            //Decode data if data is not nil
            
            let decoder = JSONDecoder()
            do{
                let decoded = try decoder.decode(Pokemon.self, from: data)
                let name = decoded.name.prefix(1).uppercased() + decoded.name.dropFirst()
                let id = decoded.id
                
                guard let abilitiesStruct = decoded.abilities,
                    let typesStruct = decoded.types else {return}
                var abilities = ""
                for ability in abilitiesStruct{
                    abilities += "\(ability.ability.name), "
                }
                var types = ""
                for ptype in typesStruct{
                    types += "\(ptype.type.name), "
                }
                
                let pokemon = Pokemon(name: name, id: id, ability: abilities, type: types)
                completion(pokemon,nil)
            } catch {
                NSLog("Error Decoding: \(error)")
                completion(nil,error)
            }
            
            }.resume()
        
    }
    
    
    func create(newPokemon:Pokemon){
        pokemons.append(newPokemon)
        
    }
    
    
    
    func delete(index: Int){
        pokemons.remove(at: index)
    }
    
    //MARK: - Properties
    private(set) var pokemons = [Pokemon]()
}
