//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jeremy Taylor on 8/10/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

class PokemonController {
    private (set) var pokemon = [Pokemon]()
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func performSearch(withText text: String, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(text)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon data from server: \(error)")
            }
            
            guard let data = data else {
                NSLog("No data returned from server")
                return
            }
            
            // We have json data decode it into Pokemon objects
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let pokemon = try jsonDecoder.decode(ReceivedData.self, from: data)
                completion(nil) // ALWAYS REMEMBER to call completion on successfull decoding!
            } catch {
                NSLog("Unable to decode data into [Pokemon]: \(error)")
                self.pokemon = []
                completion(error)
                
            }
        }.resume()
    }
}
