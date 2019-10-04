//
//  APIController.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkingError: Error {
    case noData
    case serverError(Error)
    case unexpectedStatusCode
    case badDecode
}

enum HeaderName: String {
    case contentType = "Content-Type"
}

class APIController {
    
    var pokemonList: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: Function for fetching all pokemon names
    func fetchSearchedPokemon(with searchTerm: String, completion: @escaping (Result<[Pokemon], NetworkingError>) -> Void) {
   
        
        let requestURL = baseURL
        .appendingPathComponent(searchTerm)
        
//
//         var components = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)
//
//               let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
//
//               components?.queryItems = [searchQueryItem]
//
//               guard let requestURL = components?.url else {
//                   completion()
//                   return
//               }
//
       
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue  //Setting the http protocol
        
        //MARK: DataTask for fetchingSearchedPokemon
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon objects: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("\(response.statusCode)")
                completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
            
            let pokemonList = try JSONDecoder().decode([Pokemon].self, from: data)
            
            completion(.success(pokemonList))
            
            
            
//           let decoder = JSONDecoder()
//
//            do {
//                let pokemonSearch = try decoder.decode(PokemonSearch.self, from: data)
//
//                self.pokemonNames = pokemonSearch.results
            } catch {
                NSLog("Error decoding pokemon objects: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
    }
    
    // MARK: Fetching Details of specific Pokemon function
    func fetchPokemonDetails(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkingError>) -> Void) {
        
        let requestURL = baseURL
            .appendingPathComponent(pokemonName)
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // MARK: DataTask of fetchPokemonDetail function
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon details: \(error)")
                completion(.failure(.serverError(error)))
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                completion(.success(pokemon))
                
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
    }
    
    //MARK: Fetching Pokemon Image function
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        //MARK DataTask
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from image fetch data task")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
            
        }.resume()
    }

    
    
    
    
    
    
}
