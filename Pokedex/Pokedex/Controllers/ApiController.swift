//
//  ApiController.swift
//  Pokedex
//
//  Created by Chris Dobek on 4/10/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case push = "PUSH"
}

 enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case noData
}

class APIController {

    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    
    func fetchPokemon(pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = baseURL?.appendingPathComponent(pokemonName.lowercased())
        guard let pokeurl = pokemonURL else {return}
        var request = URLRequest(url: pokeurl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data was returned from dataTask")
                return
            }
            
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode data into object: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void){
        
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }
            
            guard let data = imageData else {
                print("No data for image: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
        }.resume()
    }
    
    func addPokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
    }
    
    func deletePokemon(pokemon: Pokemon) {
        guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: index)
    }
}
