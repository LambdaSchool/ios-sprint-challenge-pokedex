//
//  PokemonController.swift
//  Pokedex
//
//  Created by Kat Milton on 6/21/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    
}

class PokemonController {
    
    var pokemonList : [Pokemon] = []
    
    private let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon")!
    
    func savePokemon(pokemon: Pokemon) {
        pokemonList.append(pokemon)
    }
    
    func deletePokemon(index: Int) {
        pokemonList.remove(at: index)
    }
    func fetchPokemon(for searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting pokemon \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data returned" )
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(nil, error)
                return
            }
            } .resume()
    }
    
//    private var persistentFileURL: URL? {
//        guard let filePath = Bundle.main.path(forResource: "pokemon", ofType: "json") else { return nil }
//        return URL(fileURLWithPath: filePath)
//    }
//    
//    func loadFromPersistentStore(completion: @escaping ([Pokemon]?, Error?) -> Void) {
//        let bgQueue = DispatchQueue(label: "pokemonQueue", attributes: .concurrent)
//        
//        bgQueue.async {
//            let fm = FileManager.default
//            guard let url = self.persistentFileURL,
//                fm.fileExists(atPath: url.path) else { return }
//            
//            do {
//                let data = try Data(contentsOf: url)
//                let decoder = JSONDecoder()
//                let pokemon = try decoder.decode([Pokemon].self, from: data)
//                completion(pokemon, nil)
//            } catch {
//                print("Error loading pokemon data: \(error)")
//                completion(nil, error)
//            }
//            
//        }
//    }
//    
//    
    
}
