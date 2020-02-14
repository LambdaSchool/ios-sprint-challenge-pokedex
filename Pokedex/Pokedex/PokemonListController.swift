//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_268 on 2/14/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import UIKit


enum HTTPMethod: String {
      case get = "GET"
  }

enum NetworkError: Error {
    case badUrl
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
    case badImage
    case noData
}
   

class PokemonAPIController {
    
    // MARK: - API Properties
    
    var pokemons: [Pokemon] = []

    
    var baseURL: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!


    
    // MARK: - PERSISTENCE
    
    var localPersistanceURL: URL? {
         let fileManager = FileManager.default
         guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
         return directory.appendingPathComponent("Pokemon.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = localPersistanceURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            print("Error Saving Data: \(error)")
        }
        
    func loadFromPersistentStore() {
        let manager = FileManager.default
        guard let url = localPersistanceURL, manager.fileExists(atPath: url.path) else { return }
        let decoder = PropertyListDecoder()
        do{
            let data = try Data.init(contentsOf: url)
            let decoded = try decoder.decode([Pokemon].self, from: data)
            pokemons = decoded
        } catch {
            print("Error Loading Pokemon Data")
        }
    }
    
    
    // MARK: - METHODS
        
    func save(pokemon: Pokemon) {
        if !pokemons.contains(pokemon) {
            pokemons.append(pokemon)
        }
        saveToPersistentStore()
    }
    
    func delete(_ pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(of: pokemon) else { return }
            pokemons.remove(at: index)
            saveToPersistentStore()
    }

    
    func fetchImage(for pokemon: Pokemon, completion: @escaping (Result< UIImage, NetworkError>) -> Void) {
        guard let imageUrl = URL(string: pokemon.sprites.sprite) else {
            completion(.failure(.badUrl))
            return
        }
    
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
    
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // check for errors
            if let error = error {
                print("Error: \(error)")
                completion(.failure(.otherError))
                return
            }
        
            // ensuring data was received
            guard let data = data else {
                completion(.failure(.badData))
                return
                }
        
            if let index = self.pokemons.firstIndex(of: pokemon) {
                self.pokemons[index].image = data
                }
            // turning binary image data into a UIImage object
            if let image = UIImage(data: data) {
                completion(.success(image))
                } else {
                    completion(.failure(.noDecode))
                    }
        }.resume()
    }
    func searchForPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let url = baseURL.appendingPathComponent(name)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // ensure response
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    completion(.failure(.badUrl))
                }
            }
                //Check for errors in API Call
                if let error = error {
                    print("Error getting data : \(String(describing: error))")
                    completion(.failure(.otherError))
                    return
                }

                //Check to ensure data has been downloaded from API
                guard let data = data else {
                    print("No Data returned")
                    completion(.failure(.noData))
                    return
                }

                //Decode JSON Data
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decoded = try jsonDecoder.decode(Pokemon.self, from: data)
                    completion(.success(decoded))
                } catch {
                    print("Error decoding data from API: \(error)")
                    completion(.failure(.noDecode))
                }

            }.resume()
            
        }
        
        
    
    
    
       // If failure, the bearer token doesn't exist
   
    
       
       
       
   

}
}
