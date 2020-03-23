//
//  APIController.swift
//  Pokedex
//
//  Created by Juan M Mariscal on 3/20/20.
//  Copyright © 2020 Juan M Mariscal. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case noAuth
    case unauthorized
    case otherError(Error)
    case noData
    case decodeFailed
}

class APIController {
    // MARK: Properties
    var pokemon: Pokemon?
    var pokeList: [Pokemon] = []

    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: Public Methods
    func fetchPokemon(for pokemonName: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let allPokemonUrl = baseUrl.appendingPathComponent("/\(pokemonName.lowercased())")
        
        var request = URLRequest(url: allPokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.unauthorized))
                return
            }
            
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
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(.failure(.otherError(error)))
                return
            }
            guard let data = data else  {
                completion(.failure(.noData))
                return
            }
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.decodeFailed))
            }
        }.resume()
    }
    
    // MARK: - Persistence
    
    func loadFromPersistentStore() {
        
        // Plist -> Data -> Stars
        let fileManager = FileManager.default
        guard let url = pokedexURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.pokeList = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("error loading stars data: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        
        // Stars -> Data -> Plist
        guard let url = pokedexURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokeList)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    private var pokedexURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = "pokedex.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
}
