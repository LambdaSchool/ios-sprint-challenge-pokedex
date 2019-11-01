//
//  PokemonController.swift
//  Pokedex
//
//  Created by Dennis Rudolph on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

let HTTPMethod = "GET"

class PokemonController {
    
    var pokemon: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func addPokemon(name: String, completion: @escaping (Pokemon?) -> Void) {
        
        let addPokemonURL = baseURL.appendingPathComponent("pokemon/\(name)/")
        
        var request = URLRequest(url: addPokemonURL)
        request.httpMethod = HTTPMethod
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("Error with Response Code (\(response.statusCode))")
                completion(nil)
                return
            }
            
            if let error = error {
                print("Error receiving gig title data: \(error)")
                completion(nil)
            }
            
            guard let data = data else {
                print("Error loading the data")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let thePokemon = try decoder.decode(Pokemon.self, from: data)
                completion(thePokemon)
            } catch {
                print("Error decoding pokemon info: \(error)")
                completion(nil)
                return
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error loading image: Bad image data")
                completion(nil)
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Error loading image: No image")
                completion(nil)
            }
        }.resume()
    }
    
    func deletePokemon(thePokemon: Pokemon) {
           if let index = pokemon.firstIndex(of: thePokemon) {
               pokemon.remove(at: index)
           }
       }
}
