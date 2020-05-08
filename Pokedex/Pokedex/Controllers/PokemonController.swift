//
//  PokemonController.swift
//  Pokedex
//
//  Created by Dahna on 5/8/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

protocol PokeDelegate {
    func currentPokemon(_ pokemon: Pokemon)
}

class PokemonController {
    
        enum HTTPmethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData
        case badEncode
        case failedFetch
        case badURL
    }
    
    var delegate: PokeDelegate?
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var searchedPokemon: Pokemon?
    var pokeList: [Pokemon] = []
    
    func fetchPokemon(searchTerm: String, completion: @escaping (NetworkError?) -> Void) {
        
        let query = searchTerm.lowercased()
        let url = baseURL.appendingPathComponent(query)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPmethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failedFetch)
                return
            }
            
            guard let data = data else {
                print("No data returned: \(String(describing: error))")
                completion(.noData)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            print("no error has been returned")
            
            do {
                let fetchedPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.searchedPokemon = fetchedPokemon
                print(fetchedPokemon.name)
                completion(nil)
            } catch {
                print("No pokemon fetched: \(error)")
                completion(.failedFetch)
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

