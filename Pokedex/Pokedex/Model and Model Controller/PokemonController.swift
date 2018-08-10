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
    
    func create(name: String, id: String, abilities: String, types: String) -> Pokemon{
        let newPokemon = Pokemon(name: name, id: id, abilities: abilities, types: types)
        pokemons.append(newPokemon)
        return newPokemon
    }
    
    func delete(pokemon:Pokemon){
        guard let index = pokemons.index(of: pokemon) else {return}
        pokemons.remove(at: index)
    }
    
    func fetch(searchName: String, completion: @escaping (Pokemon,Error?) -> Void){
        //create URL components and add search name as query item
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let queryItem = URLQueryItem(name: "name", value: searchName)
        urlComponents.queryItems = [queryItem]
        
        //turn URL Components to url
        let url = urlComponents.url!
        
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
                //FIX: May not work. Can not use "Any" as value type since not decodable
                //However, we only need the values that can be converted to String so should be okay.
                let dictionary = try decoder.decode([String:String].self, from: data)
                guard let name = dictionary["name"],
                    let id = dictionary["id"] else {return}
                //FIX: need to add abilities and types. checking fetching first.

                let pokemon = Pokemon(name: name, id: id, abilities: "PLACEHOLDER", types: "PLACEHOLDER")
                completion(pokemon,nil)
            } catch {
                
            }
            
        }.resume()

    }
    
    //MARK: - Properties
    private(set) var pokemons = [Pokemon]()
}
