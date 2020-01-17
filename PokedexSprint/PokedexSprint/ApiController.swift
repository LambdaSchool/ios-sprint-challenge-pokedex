//
//  ApiController.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 1/17/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class ApiController {
    var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")! // Could crash

    var pokemonArray: [Pokemon] = []
    
    func fetchPokemon(name: String, id: Int, completion: @escaping () -> Void) {
        let pokeUrl = baseURL.appendingPathComponent(name) // or id?
        
        var request = URLRequest(url: pokeUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 401 {
                completion()
                print("CODE: \(response.statusCode)")
                return
            }
            
            if let error = error {
                completion()
                print("ERROR in Sesh: \(error)")
                return
            }
            
            guard let data = data else {
                completion()
                print("BAD DATA")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedPokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokemonArray.append(decodedPokemon)
                print("pokemon decoded: \(decodedPokemon)")
                completion()
            } catch {
                print("DECODE error: \(error)")
                completion()
                return
            }
            print("ARRAY NOW: \(self.pokemonArray)")
            
        }.resume()
        
    }
}
