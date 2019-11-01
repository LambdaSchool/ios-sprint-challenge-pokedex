//
//  PokeController.swift
//  Pokedex-SprintChallenge
//
//  Created by morse on 11/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation
import UIKit

class PokeController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    struct HTTPMethod {
        static let get = "GET"
    }
    
    enum ErrorType: Error {
        case badResponse, otherError, noData, noDecode, noImage, badData
    }
    enum SortType {
        case name, id
    }
    
    var pokemons: [Pokemon] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    func fetchPokemon(named name: String, completion: @escaping (Result<Pokemon, ErrorType>) -> Void) {
        let url = baseURL.appendingPathComponent(name)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    completion(.failure(.badResponse))
                }
            }
            
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(.failure(.noData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decoded = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(decoded))
                print(decoded.types.compactMap({ $0.type.name }))
            } catch {
                print("Unable to decode data into object of type Pokemon: \(error)")
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func fetchImage(at urlString:
        String, completion: @escaping (Result<UIImage, ErrorType>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.noImage))
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                completion(.failure(.otherError))
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.noDecode))
            }
        }.resume()
    }
    
    func save(pokemon: Pokemon) {
        var capitalPokemon = pokemon
        capitalPokemon.name = capitalize(pokemon.name)
        pokemons.append(capitalPokemon)
        saveToPersistentStore()
    }
    
    func delete(_ pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(of: pokemon) else { return }
        pokemons.remove(at: index)
        saveToPersistentStore()
    }
    
    func sortBy(type: SortType) {
        switch type {
        case .id:
            pokemons = pokemons.sorted { $0.id < $1.id }
        case .name:
            pokemons = pokemons.sorted { $0.name < $1.name }
        }
        saveToPersistentStore()
    }
    
    func capitalize(_ word: String) -> String {
        var newWord = word
        let firstLetter = newWord.startIndex
        let capFirst = newWord[firstLetter].uppercased()
        newWord.remove(at: firstLetter)
        newWord.insert(Character(capFirst), at: firstLetter)
        return newWord
    }
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("pokemon.plist")
    }
    
    private func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL,
            fm.fileExists(atPath: url.path) else { return }
        
        do{
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            pokemons = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Error loading data: \(error)")
        }
    }
}
