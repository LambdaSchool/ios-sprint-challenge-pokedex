//
//  PokemonController.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//

// file for model controller

import Foundation

class PokemonController {

    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemonArray: [Pokemon] = []
    
    func searchPokemon(with term: String, completion: @escaping (Error?) -> Void){
        let searchURL = baseURL.appendingPathComponent(term.lowercased())
        URLSession.shared.dataTask(with: searchURL) { (data, _, error) in
            if let error = error {
                NSLog("error getting data: \(error.localizedDescription)")
                completion(error)
                return
            }
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let resultPokemon = try decoder.decode(Pokemon.self, from: data)
                
                self.pokemonArray.append(resultPokemon)
                completion(nil)
            } catch {
                print("error decoding data: \(error.localizedDescription)")
                completion(error)
                return
            }
        }.resume()
  }
    
    func fetchImage(for pokemon: Pokemon, completion: @escaping (Data?) -> Void) {
        
        let imageURL = pokemon.sprites.imageURL
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
    }.resume()
        
 }

}

