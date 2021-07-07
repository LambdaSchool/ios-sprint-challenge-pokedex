//
//  PokeController.swift
//  Pokedex
//
//  Created by Jake Connerly on 6/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class PokeController {
    
    //
    //MARK: - Properties
    //
    
    let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")! //end ID or name
    var pokeList: [PokeMon] = []
    
    func fetchPokemon(for pokemon: String, completion: @escaping (Result<PokeMon, NetworkError>) -> Void) {
        
        let pokemonUrl = baseUrl.appendingPathComponent("\(pokemon)") //make sure to get name from searchbar in detailView before method call
        
        var request = URLRequest(url: pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
      
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
           // if let response = response as? HTTPURLResponse,
           //     response.statusCode == 401 {
           //     completion(.failure(.badAuth))
           //     return
           // }
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let pokemon = try decoder.decode(PokeMon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.noDecode))
            }
            }.resume()
    }
}
