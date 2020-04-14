//
//  PokemonController.swift
//  Pokedex
//
//  Created by Gi Pyo Kim on 10/4/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkingError: Error {
    case noData
    case noBearer
    case serverError(Error)
    case unexpectedStatusCode(Int)
    case badDecode
    case badEncode
}

class PokemonController {
    
    var savedPokemons: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    // Persistence
    private var pokemonsURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("Pokemons.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = pokemonsURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let pokemonsData = try encoder.encode(savedPokemons)
            try pokemonsData.write(to: url)
        } catch {
            print("Error saving pokemons data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        do {
            guard let url = pokemonsURL, fileManager.fileExists(atPath: url.path) else { return }
            let pokemonsData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedPokemons = try decoder.decode([Pokemon].self, from: pokemonsData)
            savedPokemons = decodedPokemons
            
        } catch {
            print("Error loading pokemons data: \(error)")
        }
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    
    func searchPokemon (name: String, completion: @escaping (Result<Pokemon, NetworkingError>) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("pokemon").appendingPathComponent(name.lowercased())
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode(response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.badDecode))
            }
        }.resume()
    }
    
    
    func fetchImage(at urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from image fetch data task")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }

    func savePokemon(pokemon: Pokemon) {
        var exists = false
        for i in savedPokemons.indices {
            if pokemon.name == savedPokemons[i].name {
                exists = true
                break
            }
        }
        
        if !exists {
            savedPokemons.append(pokemon)
            saveToPersistentStore()
        }
    }
    
    func sortPokemon(by sortType: SortType) {
        
        switch sortType {
        case .name:
            savedPokemons.sort {$0.name < $1.name}
        case .id:
            savedPokemons.sort {$0.id < $1.id}
        }
    }
    
}
