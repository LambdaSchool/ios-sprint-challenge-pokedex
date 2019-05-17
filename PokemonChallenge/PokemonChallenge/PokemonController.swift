//
//  PokemonController.swift
//  PokemonChallenge
//
//  Created by Ryan Murphy on 5/17/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    var pokemonInPokedex = [Pokemon]()
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    // Fetch specific pokemon
    func fetchPokemon(named name: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                completion(nil, error)
                return
            }
            }.resume()
    }
    
    // Fetch image data
    func fetchImage(at urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let imageURL = URL(string: urlString)!
        
        var requestURL = URLRequest(url: imageURL)
        requestURL.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            let image = UIImage(data: data)!
            completion(image, nil)
            }.resume()
    }
    
    
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    
    
}



