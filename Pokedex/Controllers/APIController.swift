//
//  APIController.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

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
    
    var pokemonNames: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: Function for fetching all pokemon names
    
    func fetchSearchedPokemonNames(with searchTerm: String, completion: @escaping (Result<[String], NetworkingError>) -> Void) {
     
        
        var pathComponent = 0
               
        
        switch searchTerm {
        case "bulbasaur" :
            pathComponent = 0
        case "ivysaur" :
            pathComponent = 1
        case "venusaur" :
            pathComponent = 2
        default:
            pathComponent = 3
        }
        
        
        let requestURL = baseURL
        .appendingPathComponent(String(pathComponent))
        
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
                NSLog("Error fetching animal names: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
           let decoder = JSONDecoder()
            
            do {
                let pokemonSearch = try decoder.decode(PokemonSearch.self, from: data)
                
                self.pokemonNames = pokemonSearch.results
            } catch {
                NSLog("Error decoding animal names: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
        
        
        
    }

    
    
    
    
    
    
}
