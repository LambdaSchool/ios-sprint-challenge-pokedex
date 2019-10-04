//
//  PokemonController.swift
//  Pokedex
//
//  Created by Isaac Lyons on 10/4/19.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkingError: Error {
    case badURL
    case noInput
    case noData
    case noBearer
    case serverError(Error)
    case statusCode(Int)
    case badDecode(Error)
}

class PokemonController {
    
    init() {
        loadFromPersistentStore()
    }
    
    //MARK: Properties
    
    let baseURL = URL(string: "https://pokeapi.co")!
    
    var pokemonList: [Pokemon] = []
    
    //MARK: Actions
    
    func add(pokemon: Pokemon) {
        pokemonList.append(pokemon)
        saveToPersistentStore()
    }
    
    func remove(at index: Int) {
        pokemonList.remove(at: index)
        saveToPersistentStore()
    }
    
    func move(from oldIndex: Int, to newIndex: Int) {
        let pokemon = pokemonList[oldIndex]
        pokemonList.remove(at: oldIndex)
        pokemonList.insert(pokemon, at: newIndex)
        saveToPersistentStore()
        
    }
    
    //MARK: PokeAPI
    
    func getPokemon(from name: String, completion: @escaping (Result<Pokemon, NetworkingError>) -> Void) {
        if name.isEmpty {
            completion(.failure(.noInput))
            return
        }
        
        let requestURL = baseURL
            .appendingPathComponent("api")
            .appendingPathComponent("v2")
            .appendingPathComponent("pokemon")
            .appendingPathComponent(name)
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
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
                completion(.failure(.badDecode(error)))
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkingError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
    
    //MARK: PersistentStore
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("pokedex.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemonList)
            try data.write(to: url)
        } catch {
            NSLog("Error saving Pokedex data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            pokemonList = try decoder.decode([Pokemon].self, from: data)
        } catch {
            NSLog("Error loading Pokedex data: \(error)")
        }
    }
    
}
