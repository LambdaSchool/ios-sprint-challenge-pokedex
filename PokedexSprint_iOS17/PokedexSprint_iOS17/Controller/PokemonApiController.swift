//
//  PokemonApiController.swift
//  PokedexSprint_iOS17
//
//  Created by Stephanie Ballard on 5/8/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

class PokemonApiController {
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case failedFetch
        case noData
    }
    
    var pokedex: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    private lazy var jsonDecoder = JSONDecoder()
    
    func getPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let requestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print("getPokemonURL = \(requestURL.absoluteString)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed fetching pokemon with error: \(error)")
                completion(.failure(.failedFetch))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("Error receiving \(response)")
                completion(.failure(.failedFetch))
                return
            }
            
            guard let data = data else {
                print("No data received from fetching pokemon")
                completion(.failure(.noData))
                return
            }
            do {
                let pokemon = try self.jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding pokemon: \(error)")
                completion(.failure(.noData))
            }
        }.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
}
