//
//  PokemonController.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    
}

enum NetworkError: Error {
    case otherError
    case noAuth
    case noDecode
    case noData
}
class PokemonController {
    
    var pokemon: Pokemon?
    var pokemons: [Pokemon] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    private var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    func performSearch(searchTerm: String, completion: @escaping (Result<Pokemon,NetworkError>) -> Void) {
        
        guard let searchURL = baseURL?.appendingPathComponent( "\(searchTerm.lowercased())") else { return }
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            }
            
            guard let data = data else {
                completion(.failure(.noAuth))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(.failure(.otherError))
                return
            }
            guard let data = data else  {
                completion(.failure(.noData))
                return
            }
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func addPokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
        saveToPersistentStore()
    }
    
    func deletePokemon(pokemon: Pokemon){
        guard let index = pokemons.firstIndex(of: pokemon) else { return }
        pokemons.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("pokemon.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else {
            return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            pokemons = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("error loading books data: \(error)")
        }
    }
}
