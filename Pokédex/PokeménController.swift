//
//  PokémonController.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class PokémonController {
    
    // MARK:- Search for Pokémon
    func searchForPokémon(with searchTerm: String, completion: @escaping (Error?) -> (Void)) {
        let requestUrl = baseUrl.appendingPathComponent("Pokémon").appendingPathComponent(searchTerm)
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let _ = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was an error found searching for the given Pokémon: \(error)")
                completion(error)
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let matchedResults = try jsonDecoder.decode(Pokémon.self, from: data)
                self.matchedPokémon = matchedResults
                
                completion(nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    
    // MARK:- Adds the matched Pokémon to the user's Pokedex
    func addMatchToPokédex() {
        guard let match = matchedPokémon else { return }
        
        savedPokémon.append(match)
        savedPokémon.sort {( $0.id < $1.id )}
    }
    
    private var matchedPokémon: Pokémon?
    private(set) var savedPokémon: [Pokémon] = []
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
}
