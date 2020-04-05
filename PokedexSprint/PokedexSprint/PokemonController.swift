//
//  PokemonController.swift
//  PokedexSprint
//
//  Created by Lambda_School_Loaner_241 on 3/26/20.
//  Copyright © 2020 Lambda_School_Loaner_241. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    var pokemonArray: [Pokemon] = []
    
    func addPokemon(pkmn: Pokemon) {
        pokemonArray.append(pkmn)
    }
    
    
    func removePokemon(pkmn: Pokemon){
        guard let index = pokemonArray.firstIndex(of: pkmn) else { return }
        
        pokemonArray.remove(at: index)
        
    }
    
    func getPokemenWith(searchWord: String, completion: @escaping (Result<Pokemon, Error>)-> Void){
        let requestURL = baseURL.appendingPathComponent(searchWord.lowercased())
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print(" Error obtaining the data for the search word \(searchWord): \(error)")
                
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let pokemonObj = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemonObj)) // check pokemonObj type option + hover
            } catch {
                NSLog("Error decoding data: \(error)")
                
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func getPokemonImage(at urlString: String, completion: @escaping (UIImage?)->Void){
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching image: \(error)")
                
                completion(nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned for the image")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
        }.resume()
        
        
    }
}
