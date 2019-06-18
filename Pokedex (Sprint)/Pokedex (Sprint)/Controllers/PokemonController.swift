//
//  PokemonController.swift
//  Pokedex (Sprint)
//
//  Created by Nathan Hedgeman on 6/15/19.
//  Copyright © 2019 Nate Hedgeman. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error{
    case noPokemon
}

class PokemonController {
    
    //Properties
    var pokemonSearchResult: [Pokemon] = []
    var pokemonList: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    
    func getPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error reaching data from URL: \(error)")
                completion(.failure(.noPokemon))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noPokemon))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemonResult = try decoder.decode(Pokemon.self, from: data)
                self.pokemonSearchResult.append(pokemonResult)
            }catch {
                NSLog("Error decoding pokemon: \(Error.self)")
                completion(.failure(.noPokemon))
                return
            }
        }
        print(pokemonSearchResult)
    }
    
    func savePokemon() {
        
        let currentPokemon = self.pokemonSearchResult[pokemonSearchResult.endIndex - 1]
        pokemonList.append(currentPokemon)
        //MARK: Fetch pokemon data
    }
    
    func getPokemonImage(pokemon: Pokemon, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        //Fetch Image
        let pokeID = "\(pokemon.id)"
        
        let imageBaseURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon")
        
        var imageURL = imageBaseURL?.appendingPathComponent(pokeID)
        imageURL?.appendPathExtension("png")
        
        print(imageURL as Any)
        
        guard let pokeImageURL = imageURL else {return}
        
        URLSession.shared.dataTask(with: pokeImageURL) { (data, _, error) in
            if error != nil {
                NSLog("Error reaching image URL: \(String(describing: error))")
                completion(.failure(.noPokemon))
                return
        }
            guard let data = data else {
                completion(.failure(.noPokemon))
                return
            }
            
            guard let image = UIImage(data: data) else {return}
            completion(.success(image))
            
        }.resume()
    }
    
}


