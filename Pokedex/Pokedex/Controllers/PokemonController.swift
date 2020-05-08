//
//  PokemonController.swift
//  Pokedex
//
//  Created by Dahna on 5/8/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

class PokemonController {
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    enum HTTPmethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData
        case badEncode
        case failedFetch
        case badURL
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var searchedPokemon: Pokemon?
    var pokeList: [Pokemon] = []
    
    func fetchPokemon(searchTerm: String, completion: @escaping CompletionHandler) {
        
        let query = searchTerm.lowercased()
        let url = baseURL.appendingPathComponent(query)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPmethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.failedFetch))
                return
            }
            
            guard let data = data else {
                print("No data returned: \(String(describing: error))")
                completion(.failure(.noData))
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let fetchedPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.searchedPokemon = fetchedPokemon
                completion(.success(true))
            } catch {
                print("No pokemon fetched: \(error)")
                completion(.failure(.failedFetch))
                return
            }
        }
    task.resume()
    }
    
    func savePokemon(_ pokemon: Pokemon) {
        pokeList.append(pokemon)
    }
    
    func deletePokemon(index: Int) {
        pokeList.remove(at: index)
    }
    
    
}
