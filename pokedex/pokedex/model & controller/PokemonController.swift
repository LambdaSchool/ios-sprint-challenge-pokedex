//
//  PokemonController.swift
//  pokedex
//
//  Created by ronald huston jr on 5/28/20.
//  Copyright © 2020 HenryQuante. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    // MARK: - class properties
    typealias GetImageCompletion = Result<UIImage, NetworkError>
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    
    func fetchPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonName.lowercased())
        var request = URLRequest(url: pokemonURL)
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            //  handle error if
            if let error = error {
                print("error fetching data: \(error)")
                completion(.failure(.fetchFail))
                return
            }
            //  handle data
            guard let data = data else {
                print("no data was returned from dataTask")
                completion(.failure(.noData))
                return
            }
            //  decode pokemon
            //  need to study if the result is appended into arrray
            do {
                let fetchRequest = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(fetchRequest))
            } catch {
                print("unable to decode json into object: \(error)")
            }
        }.resume()
    }
    
    func fetchSprite(from spriteURL: String, completion: @escaping(UIImage?) -> Void){
        
        guard let imageURL = URL(string: spriteURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            if let error = error {
                print("error fetching image: \(error)")
                return
            }
            
            guard let data = imageData else {
                print("no data at URL: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
        }.resume()
    }
    
    
    func savePokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let place = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: place)
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

enum NetworkError: Error {
    case fetchFail
    case badData
    case noDecode
    case noData
}
