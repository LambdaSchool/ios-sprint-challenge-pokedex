//
//  PokemonController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 8/17/18.
//  Copyright © 2018 Lisa Sampson. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!

class PokemonController {
    
    func create(newPokemon: Pokemon) {
        pokemons.append(newPokemon)
    }
    
    func delete() {
        
    }
    
//    func fetch(searchName: String, completion: @escaping (_ success: Bool) -> Void) {
//        let url = baseURL.appendingPathComponent(searchName.lowercased())
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            if let error = error {
//                NSLog("Error: \(error)")
//                completion(false)
//                return
//            }
//
//            guard let data = data else {
//                NSLog("Data was not recieved.")
//                completion(false)
//                return
//            }
//
//            do {
//                let jsonDecoder = JSONDecoder()
//                let decodedPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
//                
//            }
//            catch {
//                
//            }
//        }.resume()
    }
    
    var pokemons: [Pokemon] = []
    
}
