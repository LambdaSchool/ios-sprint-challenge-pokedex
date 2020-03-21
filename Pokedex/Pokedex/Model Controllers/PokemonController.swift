//
//  PokemonController.swift
//  Pokedex
//
//  Created by Elizabeth Thomas on 3/20/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case loadFailed
    case decodeFailed
    case noData
    case noImage
}

class PokemonController {
    
    // MARK: - Private Properties
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: - Public Properites
    var pokemonList: [Pokemon] = []
    
    // MARK: - Private Methods
    
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
//        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//
//        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
//
//        urlComponents?.queryItems = [searchTermQueryItem]
        
//        guard let requestUrl = urlComponents?.url else { return }
        
        let pokemonUrl = baseURL.appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error fetching Pokemon: \(error)")
                completion(.failure(.loadFailed))
                return
            }
            
            guard let data = data else {
                print("Error with data: \(error)")
                completion(.failure(.noData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding Pokemon object: \(error)")
                completion(.failure(.decodeFailed))
                return
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageUrl = URL(string: urlString)!
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                completion(.failure(.noImage))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
}
