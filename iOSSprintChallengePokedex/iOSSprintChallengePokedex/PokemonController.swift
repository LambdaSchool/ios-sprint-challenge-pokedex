//
//  PokemonController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    var pokemons: [Pokemon] = []
    
    func save(pokemon: Pokemon){
        pokemons.append(pokemon)
    }

    
    func fetchPokemon(for name: String, completion: @escaping (Error?, Pokemon?) -> Void){
        
        let url = baseURL.appendingPathComponent(name)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
                
                   if let error = error {
                       print("Error receiving pokemon data: \(error)")
                       completion(error, nil)
                       return
                   }
                   
                   guard let data = data else {
                       completion(error, nil)
                       return
                   }
                   
                   let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                   do {
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(nil, pokemon)
                   } catch {
                       print("Error decoding pokemon objects: \(error)" )
                       completion(error,nil)
                       return
                   }
        }.resume()
    }
    
    
    func fetchSprite(with pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        let url = URL(string: pokemon.sprite.imageURL)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
                          if let error = error {
                              print("Error receiving pokemon image/sprite data: \(error)")
                              completion(nil)
                              return
                          }
                          guard let data = data else {
                              completion(nil)
                              return
                          }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    
    }
}
