//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Thomas Sabino-Benowitz on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    enum NetworkError: Error {
        case otherError
        case badData
        case noDecode
    }
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    var pokemonList: [Pokemon] = []
    var pokemon: Pokemon?
    
    func SearchPokemon(searchTerm: String, completion: @escaping () -> ()) {

        
        let PokemonURL = baseUrl.appendingPathComponent("\(searchTerm.lowercased())")
        var request = URLRequest(url: PokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, results, error) in
            if let error = error {
                print("ERROR receiving data for this pokemon \(error)")
                completion()
            }
            
            guard let data = data else {
                completion()
                return
            }
            let decoder = JSONDecoder()
            do{
                let pokemonData = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemonData
                completion()
            } catch {
                print("ERROR decoding the pokemon \(error)")
                completion()
                return
            }
        }.resume()
    }
}


