//
//  PokedexController.swift
//  Pokedex
//
//  Created by Josh Kocsis on 5/15/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation
import UIKit

class PokedexController {
    
    var pokemon: [Pokemon] = []
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum NetworkError: Error {
        case noData, tryAgain, invalidURL, invalidImageData
    }
    
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    private lazy var pokemonURL = URL(string: "/name/", relativeTo: baseURL)!
    
    func searchForPokemonWith(searchTerm: String, completion: @escaping () -> Void) {
            
            var urlComponents = URLComponents(url: pokemonURL, resolvingAgainstBaseURL: true)
            let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
            urlComponents?.queryItems = [searchTermQueryItem]
            
            guard let requestURL = urlComponents?.url else {
                print("request URL is nil")
                completion()
                return
            }
            
          
            var request = URLRequest(url: requestURL)
            request.httpMethod = HTTPMethod.get.rawValue
            
           
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                
                if let error = error {
                    print("Error fetching data: \(error)")
                    completion()
                    return
                }
                
                guard let self = self else { completion(); return }
                
                
                guard let data = data else {
                    print("no data returned from data task.")
                    completion()
                    return
                }
                
             
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // Decode and adding objects to array
                do {
                    let pokemonSearch = try jsonDecoder.decode(Pokemon.PokemonSearch.self, from: data)
                    self.pokemon.append(contentsOf: pokemonSearch.results)
                } catch {
                    print("Unable to decode data into object of type PokemonSearch: \(error)")
                }
                
                completion()
            }
            
            // Step 4: Run URL Task
            task.resume()
        }
    
    func fetchDetails(for pokemonName: String, completion: @escaping (Result <Pokemon, NetworkError>) -> Void) {
        
        var request = URLRequest(url: pokemonURL.appendingPathComponent(pokemonName))
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving pokemon detail data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.invalidURL))
                return
            }
            
            guard let data = data else {
                print("No data received from fetchDetails for pokemon: \(String(describing: self.pokemon.first?.name))")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let animal = try decoder.decode(Pokemon.self, from: data)
                completion(.success(animal))
            } catch {
                print("Error decoding pokemon detail data (pokemon name = \(String(describing: self.pokemon.first?.name)): \(error)")
                completion(.failure(.tryAgain))
            }
        }
        task.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let imageURL = URL(string: urlString) else { completion(.failure(.invalidURL)); return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error receiving animal image: \(urlString), error: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
                return
            } else {
                completion(.failure(.invalidImageData))
            }
        }
        task.resume()
    }
}
