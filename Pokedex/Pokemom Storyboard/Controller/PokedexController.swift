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
enum NetworkError: Error {
    
    case encodingErr
    case responseErr
    case otherErr(Error)
    case noData
    case notDecoded
    case noToken
    
}

class PokedexController {
    
    var pokemon: Pokemon?
    
    static var pokedexController = PokedexController()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func preformSearch(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
       let requestURL = baseURL.appendingPathComponent(searchTerm)
        
        
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
                completion(.failure(.noData))
                return
            }
            
            // decode the data
            
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
                completion(.success(pokemon))
                
            } catch {
                NSLog("Error retriving the results to your search: \(error)")
                completion(.failure(.notDecoded))
                return
            }
            
            
            }.resume()
        
    }
    
    
    
    
}
