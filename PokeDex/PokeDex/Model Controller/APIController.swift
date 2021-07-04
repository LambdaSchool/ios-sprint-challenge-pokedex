//
//  APIController.swift
//  PokeDex
//
//  Created by William Chen on 9/6/19.
//  Copyright © 2019 William Chen. All rights reserved.
//
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

import Foundation

class APIController {
    var users: User?
    var pokemon: [User] = []
    
    static var apiController = APIController()
    
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    typealias CompletionHandler = (Error?) -> Void
    
    func searchForPokemon (with searchTerm: String, completion: @escaping CompletionHandler = { _ in }) {
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
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
                let newUsers = try JSONDecoder().decode(User.self, from: data)
                print(newUsers)
                self.pokemon.append(newUsers)
                self.users = newUsers
            } catch {
                NSLog("Error decoding users: \(error)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
        }
    
 
}
    


