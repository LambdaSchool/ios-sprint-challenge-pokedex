//
//  PokemonResultsController.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError(Error)
    case noData
    case decodeFailed
    case noImage
}

class PokemonResultsController {
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - Properties
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("Pokemon.plist")
    }
    var savedPokemon: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    // PERSTISTENCE FUNCTIONS
    func saveToPersistentStore() {
        
        //place to store the data
        guard let pokemonListURL = persistentFileURL else { return }
        
        //Need to convert the data to something that can be stored on the phone
        do {
            //Get ready to encode the data
            let encoder = PropertyListEncoder()
            
            //the encoded data
            let pokemonData = try encoder.encode(savedPokemon)
            
            //write to the url
            try pokemonData.write(to: pokemonListURL)
            
        } catch {
            print("Error saving pokemon data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        do {
            guard let pokemonListURL = persistentFileURL else {return}
            //pull the data from the url
            let pokemonData = try Data(contentsOf: pokemonListURL)
            
            //to decode the data
            let decoder = PropertyListDecoder()
            
            // Decode the data and place in array (we specify what type to decode itself into)
            savedPokemon = try decoder.decode([Pokemon].self, from: pokemonData)
            
        } catch {
            print("error loading data: \(error)")
        }
    }
    
    // MARK: Functions
    
    
    func getPokemon(with pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let getPokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemon.lowercased())")
        
        var request = URLRequest(url: getPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodeFailed))
            }
            
        }.resume()
    }
    
    // Fetch Image
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.noImage))
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.noImage))
                return
            }
            
            completion(.success(image))
            
        }.resume()
    }
}
