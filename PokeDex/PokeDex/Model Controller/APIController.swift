//
//  APIController.swift
//  PokeDex
//
//  Created by William Chen on 9/6/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation

class APIController {
    var users: [User] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    typealias CompletionHandler = (Error?) -> Void
    
    func searchForPokemon (with searchTerm: String, completion: @escaping CompletionHandler = { _ in }) {
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm)
        
        URLSession.shared.dataTask(with: pokemonURL){ (data, _, error) in
            if let error = error {
                NSLog("Error getting users: \(error)")
            }
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil)
                return
            }
            do {
                let newUsers = try JSONDecoder().decode(UserResults.self, from: data)
                print(newUsers)
                self.users = newUsers.results
            } catch {
                NSLog("Error decoding users: \(error)")
                completion(error)
            }
            completion(nil)
            }.resume()
        }
    }
    

