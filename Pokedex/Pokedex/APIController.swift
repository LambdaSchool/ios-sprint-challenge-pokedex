//
//  APIController.swift
//  Pokedex
//
//  Created by Hannah Bain on 5/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation


class PokemonAPI {
    var pokemonCrew: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    
    func findPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
    }
}





/*
class PokemonController {
    
    var pokemonTeam: [Pokemon] = []
    
    // Step 1. Establish Base URL
    let baseURL = URL(string: "https://pokeapi.co//api/v2/pokemon/")!
    
    
    // Step 2. Create the function needed for the objects data
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
 
 // handle data/ make sure we have it
            guard let data = data else {
                print("Error getting data from data task: ")
                completion(.failure(NSError()))
                return
            }
            
            
            //Decode the JSON data Pokemon
            do {
 
 // set up encoder/decoder
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
 
 // to set up the try block = try to encode/decode object
 // create new constant value and have that equal the try to decode
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




*/




