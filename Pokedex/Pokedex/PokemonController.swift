//
//  PokemonController.swift
//  Pokedex
//
//  Created by Craig Swanson on 11/10/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    // MARK: Properties
    var pokemon: [Pokemon] = []
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    
    func performSearch (searchTerm: String, completion: @escaping (Result<Pokemon, ErrorCodes>) -> ()) {
        let searchUrl = baseUrl.appendingPathComponent(searchTerm.lowercased())
        var request = URLRequest(url: searchUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error receiving search results: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokeSearchResult = try decoder.decode(Pokemon.self, from: data)
                self.pokemon.append(pokeSearchResult)
                completion(.success(pokeSearchResult))
            } catch {
                print("Error decoding search results objects: \(error)")
                completion(.failure(.notDecodedProperly))
                return
            }
        }.resume()
        
    }
    
    // function to fetch image
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, ErrorCodes>) -> ()) {
        let imageUrl = URL(string: urlString)!
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
    
}
