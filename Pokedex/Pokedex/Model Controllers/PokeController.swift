//
//  PokeController.swift
//  Pokedex
//
//  Created by Alexander Supe on 12/8/19.
//  Copyright © 2019 Alexander Supe. All rights reserved.
//

import Foundation

class PokeController {
    
    //Attributes
    var addedPokemon = [Pokemon]()
    var currentPokemon: Pokemon?
    var sortByName = UserDefaults.standard.bool(forKey: "sortingByName"){ didSet { sortPokemon() } }
    
    //Lifecycle
    init() {
        loadFromPersistantStore()
        sortPokemon()
    }
    
    //
    func savePokemon() {
        guard let currentPokemon = currentPokemon else { return }
        addedPokemon.append(currentPokemon)
        self.currentPokemon = nil
        sortPokemon()
        saveToPersistentStore()
    }
    
    // Deletion
    func removePokemon(index: Int) {
        addedPokemon.remove(at: index)
    }
    
    // MARK: - Networking
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func catchPokemon(name: String, completion: @escaping (NetworkError?) -> Void) {
        
        let pokeURL = baseURL.appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.badAuth)
                return
            }
            
            if let _ = error {
                completion(.otherError)
                return
            }
            
            guard let data = data else {
                completion(.badData)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.currentPokemon = try decoder.decode(Pokemon.self, from: data)
                completion(nil)
            } catch {
                print("Error decoding object: \(error)")
                completion(.noDecode)
                return
            }
        }.resume()
    }
    
    // MARK: - Persistence
    var locationURL: URL? {
        let fileManager = FileManager.default
        guard let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return docDir.appendingPathComponent("Pokedex.plist")
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let dexData = try encoder.encode(addedPokemon)
            guard let fileURL = locationURL else { return }
            try dexData.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistantStore() {
        let fileManager = FileManager.default
        guard let fileURL = locationURL,
            fileManager.fileExists(atPath: fileURL.path) else { return }
        do {
            let dexData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            addedPokemon = try decoder.decode([Pokemon].self, from: dexData)
        } catch  {
            print(error)
        }
    }
    
    // MARK: - Sorting
    func sortPokemon() {
        if sortByName {
            addedPokemon.sort{ $0.name < $1.name }
            UserDefaults.standard.set(true, forKey: "sortingByName")
        } else {
            addedPokemon.sort{ $0.id < $1.id }
            UserDefaults.standard.set(false, forKey: "sortingByName")
        }
    }
    
}

// MARK: - Enums
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

