//
//  PokemonController.swift
//  Pokedex
//
//  Created by Lisa Sampson on 5/10/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    // MARK: - Properties
    
    var pokedex: [Pokemon] = []
    var pokemon: Pokemon?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    // MARK: - CRUD
    
    func create(pokemon: Pokemon) {
        pokedex.append(pokemon)
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = pokedex.firstIndex(of: pokemon) else { return }
        pokedex.remove(at: index)
    }
    
    // MARK: - Networking
    
    func fetch(searchName: String, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent(searchName.lowercased())
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("There was an error with your pokemon session: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Pokemon data was not recieved.")
                completion(error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.pokemon = decodedPokemon
                completion(nil)
            }
            catch {
                NSLog("There was an error decoding Pokemon: \(error)")
                completion(error)
                return
            }
            }.resume()
    }
    
    // MARK: - Image Loading
    
//    func fetchImage(at urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
//
//        let imageURL = URL(string: urlString)!
//
//        var request = URLRequest(url: imageURL)
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            if let error = error {
//                NSLog("There was an error with your image session: \(error)")
//                completion(nil, error)
//                return
//            }
//
//            guard let data = data else {
//                NSLog("Image data was not recieved.")
//                completion(nil, error)
//                return
//            }
//
//            let image = UIImage(data: data)!
//            completion(image, nil)
//            }.resume()
//    }
}
