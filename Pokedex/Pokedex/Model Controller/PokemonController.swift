//
//  PokemonController.swift
//  Pokedex
//
//  Created by Mitchell Budge on 5/17/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class PokemonController {
    var pokemon: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    func searchPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let url = baseURL.appendingPathComponent(searchTerm.lowercased())
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for Pokemon: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("Error retrieving data")
                completion(error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let searchPokemon = try decoder.decode(Pokemon.self, from: data)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
}
