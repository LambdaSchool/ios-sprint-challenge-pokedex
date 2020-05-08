//
//  PokemonController.swift
//  Pokedex
//
//  Created by Kelson Hartle on 5/8/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation
import UIKit


final class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
        
    }
    
    var results: [Pokemon] = []

    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func performSearch(searchTerm: String, resultType: Pokemon, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let parameters : [String : String] = ["term" : searchTerm, "entity" : resultType.rawValue]
        
        let queryItems = parameters.compactMap({URLQueryItem(name: $0.key, value: $0.value)})
        
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //Creating data task
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            //Get the data and turn it into an array of cards
            if let error = error {
                
                NSLog("Error with data task: \(error)")
            }
            
            guard let data = data else {
                completion()
                return
            }
            
            //The data constant is JSON
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(PokemonResults.self, from: data)
                self.results.append(contentsOf: searchResults.results)
                
            }  catch {
                NSLog("Error with data task: \(error)")
            }
            
            completion()
            
        }.resume()
        
    }
}





