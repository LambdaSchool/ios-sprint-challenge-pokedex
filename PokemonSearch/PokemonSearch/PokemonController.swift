//
//  PokemonController.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")! //{id or name}/


class PokemonController {
    
    func searchForPokemon(with searchTerm: String, completion: @escaping ([Pokemon]?, Error?) -> Void) {
      /*  var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem = URLQueryItem(name: ", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem]*/
        
        let url = baseURL.appendingPathComponent(searchTerm)
        
     /*   guard let requestURL = urlComponents.url else {
            NSLog("Problem constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }*/
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned.")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let searchResults = try jsonDecoder.decode(PokemonSearchResults.self, from: data)
                let pokemon = searchResults.results
                completion(pokemon, nil)
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil, error)
                return
            }
            
        }
        dataTask.resume()
        
    }
}

/*URLSession.shared.dataTask(with: url) { (data, _, error) in
    if let error = error {
        completion(error)
        return
    }
    
    guard let data = data else {
        completion(NSError())
        return
    }
    
    let jsonDecoder = JSONDecoder()
    
    do {
        let decodedDict = try jsonDecoder.decode([String: Entry].self, from: data)
        let entries = Array(decodedDict.values)
        self.entries = entries
        completion(nil)
    } catch {
        print("Error decoding received data: \(error)")
        completion(error)
        return
    }
    
    }.resume()

}*/
