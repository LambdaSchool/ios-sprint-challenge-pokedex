//
//  PokemonController.swift
//  ios-sprint3-challenge
//
//  Created by De MicheliStefano on 10.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

class PokemonController {
    
    // MARK: - Methods
    
    func save(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    func fetchPokemons(for name: String, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(name)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error while fetching pokemon: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error while fetching pokemon")
                completion(NSError())
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemon = decodedData
            } catch {
                NSLog("Error while decoding pokemon: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    var pokemons: [Pokemon] = []
    let baseURL: URL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!
    
}
