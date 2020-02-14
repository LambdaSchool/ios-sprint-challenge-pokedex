//
//  PokemonAPIController.swift
//  PokedexApp
//
//  Created by Lambda_School_Loaner_218 on 12/6/19.
//  Copyright © 2019 Lambda_School_Loaner_218. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    
    case otherError
    case badData
    case noDecode
    case invalidURL
    case badResponse
    
}

class PokemonAPIController {
    
   private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
        var pokemons:[Pokemon] = []
        
        init() {
            loadFromPersistentStore()
        }
        

        
        func fetchPokemonImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void ) {
            guard let pokemonFrontSpriteURL = URL(string: urlString) else {
                completion(.failure(.badData))
                return
            }
            
            var request = URLRequest(url:pokemonFrontSpriteURL)
            request.httpMethod = HTTPMethod.get.rawValue
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("There was an error querying the frontDefault image url for the pokemon of type \(error)")
                    completion(.failure(.otherError))
                }
                
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    completion(.failure(.badResponse))
                    return
                    
                }
                guard let data = data  else {
                    completion(.failure(.badData))
                    return
                }
                
                guard let frontSpritePicture = UIImage(data:data) else { return }
                DispatchQueue.main.async {
                    completion(.success(frontSpritePicture))
                }
            }.resume()
            
            
        }
    
    func findPokemon(for pokemonName:String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonUrl = baseUrl.appendingPathComponent("pokemon/\(pokemonName.lowercased())/")
        
        var request = URLRequest(url:pokemonUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.badResponse))
                return
            }
            
            if let error = error {
                print("Error receiving pokemon \(pokemonName) details data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("Data not recieved")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding pokemon from data into pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
            
        }.resume()
        
        
    }
        
        func save(pokemon:Pokemon){
            self.pokemons.append(pokemon)
            saveToPersistentStore()
        }
        
        func delete (_ pokemon:Pokemon) {
            guard let location = pokemons.firstIndex(of:pokemon) else {return}
            pokemons.remove(at:location)
            saveToPersistentStore()
            
        }
        
        private var savedPokemonURL: URL? {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            
            let fileName = "pokemonList.plist"
            
            return documentDirectory.appendingPathComponent(fileName)
        }
        
        private func saveToPersistentStore() {
            
            let plistEncoder = PropertyListEncoder()
            
            do {
                let notebooksData = try plistEncoder.encode(pokemons)
                
                guard let fileURL = savedPokemonURL else { return }
                
                try notebooksData.write(to: fileURL)
            } catch {
                NSLog("Error encoding memories to property list: \(error)")
            }
        }
        
        private func loadFromPersistentStore() {
            let fileManager = FileManager.default
            do {
                guard let fileURL = savedPokemonURL, fileManager.fileExists(atPath: fileURL.path) else { return }
                
                let notebooksData = try Data(contentsOf: fileURL)
                
                let plistDecoder = PropertyListDecoder()
                
                self.pokemons = try plistDecoder.decode([Pokemon].self, from: notebooksData)
            } catch {
                NSLog("Error decoding memories from property list: \(error)")
            }
        }
        
        
    }
