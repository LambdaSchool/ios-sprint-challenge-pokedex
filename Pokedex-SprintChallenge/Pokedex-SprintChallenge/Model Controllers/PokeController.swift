//
//  PokeController.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

class PokeController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    struct HTTPMethod {
        static let get = "GET"
    }
    
    var pokemons: [Pokemon] = []
    var currentPokemon: Pokemon?
    
    func fetchPokemon(named name: String, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(name)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //            print(request)
            if let error = error {
                print("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let decoded = try jsonDecoder.decode(Pokemon.self, from: data)
                self.currentPokemon = decoded
                completion(nil)
            } catch {
                print("Unable to decode data into object of type Pokemon: \(error)")
                completion(error)
            }
            print(self.currentPokemon?.name)
        }.resume()
        
        print(url)
    }
}
