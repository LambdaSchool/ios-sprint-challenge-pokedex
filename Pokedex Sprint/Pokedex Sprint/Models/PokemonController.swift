//
//  PokemonController.swift
//  Pokedex Sprint
//
//  Created by Alex Shillingford on 6/21/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class PokemonController {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    private var imageC: UIImage?
    var pokemon: Pokemon?
    var pokemonList: [Pokemon] = []
    
    func searchPokemon(pokemonName: String, completion: @escaping (Error?) -> Void) {
        let allPokemonURL = baseURL.appendingPathComponent("pokemon")
        let searchPokemonURL = allPokemonURL.appendingPathComponent(pokemonName)
        var request = URLRequest(url: searchPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemonSearch = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemonSearch
            } catch {
                print("Error decoding pokemon: \(error)")
            }
        }.resume()
    }
    
}
