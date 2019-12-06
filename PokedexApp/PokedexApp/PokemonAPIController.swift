//
//  PokemonAPIController.swift
//  PokedexApp
//
//  Created by Lambda_School_Loaner_218 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
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

class PokemonAPIController {
    
    var pokemons: [Pokemon] = []
    let baseURL = URL(string: "https://pokeapi.co//api/vs/pokemon/")!
    
    func searchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(searchTerm)/")
        
        var request = URLRequest(url: pokemonURL)
               request.httpMethod = HTTPMethod.get.rawValue
               request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            
            if let error = error {
                print("Error receving animal (\(searchTerm)) data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokeSearch = try decoder.decode(Pokemon.self, from: data)
            } catch {
                print("Unable to decode data into object of type [Person]: \(error)")
                }
                DispatchQueue.main.async {
                    completion(.failure(.noDecode))
                }
            
        }.resume()
     
 }

}
