//
//  PokemonController.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var savedPokemon: [Pokemon] = []
    


    func getPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void ) {
        let getPokemonURL = baseURL.appendingPathComponent("pokemon/\(searchTerm)")
            
        
//        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//
//        let searchTermQuery = URLQueryItem(name: "pokemon", value: searchTerm)
//
//        urlComponents?.queryItems = [searchTermQuery]
//        guard let requestURL = urlComponents?.url else {
//            print("Request URL is nil")
//            completion(.failure(.otherError))
//            return
//        }
    
        var request = URLRequest(url: getPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Error w/ response code")
                completion(.failure(.otherError))
                return
            }
            
            if let error = error {
                print("Error fetching pokemon data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("No data returned from data task")
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let aPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
//                self.savedPokemon = []
//                self.savedPokemon.append(searchResults.self)
            } catch {
                print("Unable to decode data into object of type [SarchResult]: \(error)")
                completion(.failure(.noDecode))
            }
            
        }.resume()
    
    }
    
    
    
    func savePokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
    }



}



