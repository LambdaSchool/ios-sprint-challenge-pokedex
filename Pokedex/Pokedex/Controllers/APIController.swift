//
//  APIController.swift
//  Pokedex
//
//  Created by Brandi on 11/1/19.
//  Copyright © 2019 Brandi. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
}

class APIController {
    
    private var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var pokemon: Pokemon?
    var pokeList: [Pokemon] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    // Fetch a pokemon
    
    func fetchAPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        guard let pokeURL = baseURL?.appendingPathComponent("/\(searchTerm.lowercased())") else { return }
        
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                print("Ohhhh.  Did we get something?!?!")
                completion(.success(pokemon))
            } catch {
                print("He's dead, Jim. \(error)")
                completion(.failure(.noDecode))
                return
            }
        }
        task.resume()
    }
    
    // Fetch Pokemon Image 'Sprite'
    
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
    

    // Mark: Persistence
    
    func loadFromPersistentStore() {
        do {
            guard let fileURL = pokedexURL else { return }
            let pokemonData = try Data(contentsOf: fileURL)
            let pListDecoder = PropertyListDecoder()
            self.pokeList = try pListDecoder.decode([Pokemon].self, from: pokemonData)
        } catch {
            print("There was an error retreiving your Pokedex: \(error)")
        }
    }
    
        func saveToPersistentStore() {
            
            let plistEncoder = PropertyListEncoder()
            
            do  {
                let pokemonData = try plistEncoder.encode(pokeList)
                guard let fileURL = pokedexURL else { return }
                try pokemonData.write(to: fileURL)
            } catch {
                print("There was an error saving your foodMinders: \(error)")
            }
        }
        
        
        private var pokedexURL: URL? {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileName = "pokedex.plist"
            
            return documentDirectory?.appendingPathComponent(fileName)
        }
    
}
    

