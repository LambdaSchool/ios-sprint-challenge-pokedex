//
//  APIController.swift
//  pokedex
//
//  Created by Sammy Alvarado on 5/17/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation
import UIKit


class APIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/4")!
    var searchResults: [Pokemon] = []
    
//    enum HTTPMethod: String {
//        case get = "Get"
//        case post = "Post"
//    }
//
//    enum NetworkError: Error {
//        case invalidURL
//    }
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        //Append search term to URL
        // Retrevieting the pokemon terms, Lowercase is due to the data being lowercase in API
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        URLSession.shared.dataTask(with: pokemonURL) { (data, _, error) in
            
            // Error handling
            if let error = error {
                print("Error getting pokemon: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("Error getting dtat from data task: ")
                completion(.failure(NSError()))
                return
            }
            
            // Decoding The Jason Data Pokemon
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
        }  .resume()
        
    }
    
    func addPokemon(pokemon: Pokemon){
            searchResults.append(pokemon)
        }
}

 

/*
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
 
 */

 


