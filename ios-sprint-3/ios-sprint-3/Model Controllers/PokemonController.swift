//
//  PokemonController.swift
//  ios-sprint-3
//
//  Created by Lambda-School-Loaner-11 on 8/10/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/")!

class PokemonController {
    
    var pokemons : [Pokemon] = []
    
    private enum HTTPMethod: String {
        case get = "GET"
        case delete = "DELETE"
    }
    
    
    func performSearch(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let searchQueryItem = URLQueryItem(name: "name", value: searchTerm)
        
        let typeQueryItem = URLQueryItem(name: "type", value: searchTerm)
        
        let abilitiesQueryItem = URLQueryItem(name: "ability", value: searchTerm)
        
        urlComponents.queryItems = [searchQueryItem, typeQueryItem, abilitiesQueryItem]
        
        
        guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing URL for \(searchTerm)")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error as NSError? {
                NSLog("Error fetching data \(error)")
                completion(NSError())
                return
            }
            
            guard let data = data else {
                completion(NSError())
                NSLog("Error fetching data")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                
                let pokemons = try jsonDecoder.decode(Pokemons.self, from: data)
                self.pokemons = pokemons.results
                
                completion(nil)
            } catch {
                NSLog("Unable to decode data")
                completion(NSError())
            }
        }.resume()
    }
    
    
    func delete(pokemon: Pokemon, completion: @escaping (Error?) -> Void) {
        
        guard let index = self.pokemons.index(of: pokemon) else { return }
        
        self.pokemons.remove(at: index)
        
        let url = baseURL
            .appendingPathComponent(pokemon.id)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
}
