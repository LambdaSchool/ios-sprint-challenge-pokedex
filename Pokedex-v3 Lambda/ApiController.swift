//
//  ApiController.swift
//  Pokedex-v3
//
//  Created by Austin Potts on 9/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class PokemonController {
    
    var pokemonTeam: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co//api/v2/pokemon/")!
    
    func getPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, Error>)-> Void){
        
        //Append search Term to url
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
           
           //Error Handling
            if let error = error {
                print("Error getting pokemon: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("Error getting data from data task: ")
                completion(.failure(NSError()))
                return
            }
            
            
            //Decode the JSON data Pokemon
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                print(pokemon)
                completion(.success(pokemon))
            } catch {
                print("Error decoding data to type Pokemon: \(error)")
                completion(.failure(error))
                
            }
            
        }.resume()
        
    }
    
    func addPokemon(pokemon: Pokemon){
        pokemonTeam.append(pokemon)
    }
    
}
