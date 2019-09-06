//
//  PokedexController.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET" // read only
    case put = "PUT" // create data
    case post = "POST" // update or replace data
    case delete = "DELETE" // delete data
    
}

class PokedexController {
    
    var pokemon: Pokemon?
    
    static var pokedexController = PokedexController()
    
    let baseURL = URL(string: "https://pokeapi.co")!
    
    
    func preformSearch(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent("api").appendingPathComponent("v2").appendingPathComponent("pokemon")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "name", value: searchTerm)
       
        
        components?.queryItems = [searchItem]
        
        guard let requestURL = components?.url else {
            NSLog("Error unwrapping request URL")
            return
            
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // data task not ran yet
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // check to see that we can connect to the api for search, this is happeneing after the data task has run.
            if let error = error {
                NSLog("Error retrieving searched object: \(error)")
            }
            
            //check to see if we recieved the results from the search
            guard let data = data else {
                NSLog("No data returned from search.")
                completion(nil)
                return
            }
            
            // decode the data
            let decoder = JSONDecoder()
            
            do {
                
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                self.pokemon = pokemon
                completion(nil)
                
            } catch {
                NSLog("Error retriving the results to your search: \(error)")
                completion(error)
            }
            completion(nil)
            
            }.resume()
        
    }
    
    
    
    
}
