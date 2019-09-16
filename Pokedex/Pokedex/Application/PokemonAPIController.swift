//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 16/09/2019.
//  Copyright © 2019 Eoin Lavery. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class PokemonAPIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    var searchResult: Pokemon?
    var savedPokemon: [Pokemon] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else { return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.otherError))
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            completion(.success(image))
        }.resume()
    }
    
    func getPokemon(for pokemon: String, completion: @escaping (Error?) -> Void) {
        guard let searchURL = baseURL?.appendingPathComponent("/pokemon/\(pokemon.lowercased())") else { return }
        
        print("Method Started")
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        print("Request URL Created")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                print("Error found: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("Data Not Found")
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.searchResult = pokemon
                completion(nil)
                print("Pokemon Found")
            } catch {
                print("Error decoding JSON data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
    }
    
    var pokemonListURL: URL? {
        let fileManager = FileManager()
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("PokemonList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = pokemonListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let pokemonData = try encoder.encode(savedPokemon)
            try pokemonData.write(to: url)
        } catch {
            print("Error saving Pokemon to file: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = pokemonListURL, fileManager.fileExists(atPath: url.path) else { return }
        let decoder = PropertyListDecoder()
        do {
            let data = try Data.init(contentsOf: url)
            let decodedPokemon = try decoder.decode([Pokemon].self, from: data)
            savedPokemon = decodedPokemon
        } catch {
            print("Error retrieving pokemon from file: \(error)")
        }
    }
    
    func savePokemon(for pokemon: Pokemon) {
        savedPokemon.append(pokemon)
        saveToPersistentStore()
    }
    
}
