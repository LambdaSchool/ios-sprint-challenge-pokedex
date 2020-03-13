//
//  Pokemon Controller.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 3/13/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case badUrl
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}
class PokemonController {
 var searchResults: [Pokemon] = []
private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
    
    func performSearch(searchTerm: String,  completion: @escaping (Error?) -> Void ) {
        
        let allPokemonUrl = baseUrl.appendingPathComponent("pokemon")
         var urlComponents = URLComponents(url: allPokemonUrl, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [ URLQueryItem(name: "term", value: searchTerm)
        ]
                                   
    
         guard let requestURL = urlComponents?.url else {
         NSLog("request url is nil")
             let error = NSError(domain: "url construction failed", code: 1)
         completion(error)
         return
             
         }
    var request = URLRequest(url: requestURL)
           request.httpMethod = "GET"
         
           URLSession.shared.dataTask(with: request) { (data, _, error) in
               if let error = error {
                   NSLog("Error fetching data \(error)" )
                   completion(error)
                   return
               }
               guard let data = data else { // we want the data to exist so we need to unwrapp it
                   NSLog("No data return from data task ")
                   completion(error)
                   return
               }
               
               do {
                 let pokemonSearch = try JSONDecoder().decode(SearchResults.self, from: data)
                self.searchResults  = pokemonSearch.results
               } catch {
                   NSLog("Unable to decode the data into object of type [SearchResult]: \(error)")
               }
               completion(nil)
           } .resume()
     }
    
    func fetchAllPokemonlNames(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        
        
        let allPokemonUrl = baseUrl.appendingPathComponent("pokemon")
        
        var request = URLRequest(url: allPokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
       
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving animal name data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                // User is not authorized (no token or bad token)
                NSLog("Server responded with 401 status code (not authorized).")
                completion(.failure(.badAuth))
                return
            }
            
            guard let data = data else {
                NSLog("Server responded with no data to decode.sup")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemonNames = try decoder.decode([String].self, from: data)
                completion(.success(pokemonNames))
            } catch {
                NSLog("Error decoding animal objects: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    func getPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        
        let pokemonUrl = baseUrl.appendingPathComponent("pokemon/\(pokemonName)")
        
        var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
       
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving animal name data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                // User is not authorized (no token or bad token)
                NSLog("Server responded with 401 status code (not authorized).")
                completion(.failure(.badAuth))
                return
            }
            
            guard let data = data else {
                NSLog("Server responded with no data to decode.sup")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding animal object \(pokemonName): \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
     func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
           
           guard let imageUrl = URL(string: urlString) else {
               completion(.failure(.badUrl))
               return
           }
           
           var request = URLRequest(url: imageUrl)
           request.httpMethod = HTTPMethod.get.rawValue
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   NSLog("Error receiving animal image data: \(error)")
                   completion(.failure(.otherError))
                   return
               }
               
               guard let data = data else {
                   NSLog("GitHub responded with no image data.")
                   completion(.failure(.badData))
                   return
               }
               
               guard let image = UIImage(data: data) else {
                   NSLog("Image data is incomplete or corrupted.")
                   completion(.failure(.badData))
                   return
               }
               
               completion(.success(image))
           }.resume()
       }
}
