//
//  APIController.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation

struct PokemonController: Decodable {
    
    var pokemonList: [Pokemon] = []
    
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    enum NetworkError: Error{
        case tryAgain
        case noData
        case networkFailure
    }
    
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func searchForPokemonWith(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let searchURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        var requestURL = URLRequest(url: searchURL)
        requestURL.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                print("error requesting data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.networkFailure))
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
        task.resume()
    }
    
}
