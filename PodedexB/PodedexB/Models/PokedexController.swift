//
//  PokedexController.swift
//  PodedexB
//
//  Created by Gerardo Hernandez on 1/26/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "Post"
    case delete = "Delete"
    
}

enum NetworkError: Error {
    case notFound
    case badAuth
    case otherError
    case badData
    case decodingError
}


class PokedexController {
    
    // MARK: - Properties
    var pokemons: [Pokemon] = []
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
    
    // MARK: - Methods
    
    func pokemonSearch(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonSearchUrl = baseUrl.appendingPathComponent("pokemon/\(searchTerm.lowercased())")

        var request = URLRequest(url: pokemonSearchUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
                   if let response = response as? HTTPURLResponse,
            response.value(forHTTPHeaderField: "Content-Type") == "Not Found" {
                    completion(.failure(.otherError))
                    return
            }
            guard error == nil else {
                completion(.failure(.otherError))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
        
        let jsonDecoder = JSONDecoder()
        do {
            let search = try jsonDecoder.decode(Pokemon.self, from: data)
            completion(.success(search))
        } catch {
            print("Error encoding user object: \(searchTerm) \(error)")
            completion(.failure(.decodingError))
            return
        }
       
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
         guard let imageUrl = URL(string: urlString) else {
             completion(.failure(.otherError))
             return
         }
         
         var request = URLRequest(url: imageUrl)
         request.httpMethod = HTTPMethod.get.rawValue
         
         URLSession.shared.dataTask(with: request) { (data, _, error) in
             guard error == nil else {
                 completion(.failure(.otherError))
                 return
             }
             
             guard let data = data else {
                 completion(.failure(.badData))
                 return
             }
             guard let image = UIImage(data: data) else {
                 completion(.failure(.decodingError))
                 return
             }
             completion(.success(image))
         }.resume()
     }
    
    func savePokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func delete(_ pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
}
