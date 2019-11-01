//
//  PokemonController.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

fileprivate let HTTPMethod = (
    get: "GET",
    post: "POST"
)

enum NetworkError: String, Error {
    case otherError = "Unknown error occurred: see log for details."
    case badData = "No data received, or data corrupted."
    case noDecode = "JSON could not be decoded. See log for details."
    case badImageURL = "The image URL could not be found."
}

class PokemonController {
    var pokemonList: [Pokemon] = []
    
    let baseURL: URL = URL(string: "https://pokeapi.co/api/v2")!
    
    func performSearch(for pokemonName: String, completion: @escaping (Result<Pokemon,NetworkError>) -> Void) {
        let searchTerm = pokemonName.lowercased()
        let searchURL = baseURL.appendingPathComponent("pokemon/\(searchTerm)")
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print(NSError(domain: "", code: response.statusCode, userInfo: nil))
                completion(.failure(.otherError))
                return
            }
            
            if let error = error {
                print(error)
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let apiPokemon = try jsonDecoder.decode(APIPokemon.self, from: data)
                
                let imageURL = apiPokemon.sprites.frontDefault
                
                var types = [String]()
                for type in apiPokemon.types {
                    types.append(type.type.name.capitalized)
                }
                
                var abilities = [String]()
                for ability in apiPokemon.abilities {
                    abilities.append(ability.ability.name.capitalized)
                }
                
                let foundPokemon = Pokemon(name: apiPokemon.name.capitalized, id: apiPokemon.id, types: types, abilities: abilities, imageURL: imageURL)
                self.pokemonList.append(foundPokemon)
                
                completion(.success(foundPokemon))
            } catch {
                print(error)
                completion(.failure(.noDecode))
            }
        }
        task.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
}
