//
//  PokemonController.swift
//  PokedexIOSPT3
//
//  Created by Jessie Ann Griffin on 11/10/19.
//  Copyright © 2019 Jessie Griffin. All rights reserved.
//

import Foundation
import UIKit

let pokemonListKey = "pokemonListKey"

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")
    var pokemon: Pokemon?
    var pokeList: [Pokemon] = []
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let baseURL = baseURL else {
            completion(.failure(.otherError))
            return
        }
        
        let pokeURL = baseURL.appendingPathComponent("pokemon/\(searchTerm)")
        print(pokeURL)
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethods.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(.failure(.otherError))
            }
            
            guard let data = data else {
                print("No data was returned from task.")
                completion(.failure(.badData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Unable to decode data into pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethods.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            }
        }.resume()
    }
    
    // Persistence
    let userDefaults = UserDefaults.standard
        
    private var pokemonListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("PokemonList.plist")
    }
    
    init() {
        let userDefault = UserDefaults.standard.bool(forKey: pokemonListKey)
        // if it's true it means the app has been run before
        if userDefault {
            loadFromPersistentStore() // populates array from saved data
        } else {
 //           createPokemonList() // creates array
        }
    }
    
//    private func createPokemonList() {
//        
//        for poke in pokeList {
//            let newPoke = try? Pokemon(from: poke)
//            pokeList.append(newPoke)
//        }
//        saveToPersistentStore()
//        // this saves the "key" info that this function has already been run once
//        userDefaults.set(true, forKey: pokemonListKey)
//    }
//    
    private func saveToPersistentStore() {
        guard let url = pokemonListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let listData = try encoder.encode(pokeList)
            try listData.write(to: url)
        } catch {
            print("Error saving shopping list data: \(error)")
        }
    }
    
    // method to load data from the url created when saving the data - this method also checks if the file exists
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        do {
            guard let url = pokemonListURL, fileManager.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedList = try decoder.decode([Pokemon].self, from: data)
            self.pokeList = decodedList
        } catch {
            print("Error loading/decoding shopping list: \(error)")
        }
    }
}
