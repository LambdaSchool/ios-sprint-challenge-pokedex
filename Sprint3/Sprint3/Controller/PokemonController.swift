//
//  PokemonController.swift
//  Sprint3
//
//  Created by Victor  on 5/10/19.
//  Copyright © 2019 com.Victor. All rights reserved.
//

import Foundation

class PokemonController {
    
    var pokemons: [Pokemon] = []
    var pokemon: Pokemon?
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }

    func save() {
        guard let pokemon = pokemon else { return }
        pokemons.append(pokemon)
        pokemons = pokemons.sorted { $0.id < $1.id }
        self.pokemon = nil
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    func fetchPokemons(for name: String, completion: @escaping (Error?) -> Void) {
        var searchURL = baseURL.appendingPathComponent("pokemon")
        searchURL = searchURL.appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let data = try jsonDecoder.decode(Pokemon.self, from: data)
                print(data)
                self.pokemon = data
                completion(nil)
            } catch {
                NSLog("Error while decoding pokemon: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    func getData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let jsonUrl = url
        var request = URLRequest(url: jsonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            completion(data, error)
            }.resume()
    }
    
}
