//
//  PokemonController.swift
//  pokedex
//
//  Created by Joshua Sharp on 9/6/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError
    case noData
    case noDecode
    case noToken
}

class PokemonController {
    var savedPokemon: [Pokemon] = []
    var foundPokemon: Pokemon?
    var baseURL = URL(string:"https://pokeapi.co/api/v2/")!
    
    init () {
        
    }
    
    typealias Closure = (NetworkError?) -> Void
    
    func findPokemon(with name: String, completion : @escaping Closure) {
        let requestURL = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(name)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.responseError)
                return
            }
            
            if let error = error {
                NSLog("Error fetching pokemon details: \(error)")
                completion(.otherError)
                return
            }
            
            guard let data = data else {
                completion(.noData)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                self.foundPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(nil)
            } catch let decodingError {
                NSLog("Error decoding animal: \(decodingError)")
                completion(.noDecode)
                return
            }
            }.resume()
    }
}
