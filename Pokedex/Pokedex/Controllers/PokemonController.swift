//
//  APIController.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

enum NetworkError: Error {
    case tryAgain
    case noData
    case NetworkError
}

class PokemonController {
    
    var pokemonList: [Pokemon] = []
    var pokemonImages: [URL] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
 
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonUrl = baseURL?.appendingPathComponent(searchTerm.lowercased())
        
        guard let requestUrl = pokemonUrl else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: requestUrl) { (data, _, error) in
            if let error = error {
                print("error requesting data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            guard let data = data else {
                print("error receiving data")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print ("error decoding data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
        }
        .resume()
    }
    
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
                var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            

        if let error = error{
            NSLog("Error fetching image: \(error)")
            return
            }
            guard let data = imageData else {
                NSLog("No data provided for image: \(imageURL)")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
        
    }
    
    func addPokemon(pokemon: Pokemon) {
        pokemonList.append(pokemon)
    }
    
}
