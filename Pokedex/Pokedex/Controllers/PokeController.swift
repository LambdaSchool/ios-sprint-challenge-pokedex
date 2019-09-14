//
//  PokeController.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

let GET = "GET"
let appJSON = "application/json"
let contentType = "Content-Type"

enum PokeError: Error {
    case noData
    case notFound
}


class PokeController {
    var baseUrl = URL(string: "https://pokeapi.co/api/v2/")
    var encounteredPokemon: [Pokemon] = []
    
//    func catchEmAll() {
//        // Get the full list ok Pokémon (part of strech goal)
//    }
    
    func fetchPokemon(name: String? = nil, id: Int? = nil, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        guard let baseUrl = baseUrl else { fatalError() }

        var nameOrId = ""
        if let name = name, !name.isEmpty {
            nameOrId = name.lowercased()
        } else if let id = id {
            nameOrId = "\(id)"
        }
        
        let pokeUrl = baseUrl.appendingPathComponent("pokemon/\(nameOrId)")
        var request = URLRequest(url: pokeUrl)
        
        request.httpMethod = GET
        request.setValue(appJSON, forHTTPHeaderField: contentType)
        
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            let pokemon: Pokemon
            if let err = err {
                print("Error getting \(nameOrId): \(err)")
                completion(.failure(err))
            }
            
            if let res = res as? HTTPURLResponse, res.statusCode != 200 {
                switch res.statusCode {
                case 404:
                    completion(.failure(PokeError.notFound))
                    return
                default:
                    completion(.failure(NSError(domain: "fetchPokemon(name:)", code: res.statusCode, userInfo: nil)))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(PokeError.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                pokemon = try decoder.decode(Pokemon.self, from: data)
                self.encounteredPokemon.append(pokemon)
            } catch {
                print("Error decoding \(nameOrId): \(error)")
                completion(.failure(error))
                return
            }
            
            completion(.success(pokemon))
        }.resume()
    }
    
    func addToEncountered(_ pokemon: Pokemon) {
        encounteredPokemon.append(pokemon)
    }
}
