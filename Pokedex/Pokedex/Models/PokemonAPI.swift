//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Bohdan Tkachenko on 5/16/20.
//  Copyright © 2020 Bohdan Tkachenko. All rights reserved.
//

import Foundation
import UIKit

class PokemonAPI: Codable {
    
   private(set)var pokemon: [Pokemon] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        
    }
    
    enum NetworkError: Error {
        case noData, failedSignUp, failedSignIn, noToken, tryAgain, invalidURl
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api")!
    private lazy var pokemonURL = baseURL.appendingPathComponent("/v2/pokemon/")
    
    func getPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURLName = pokemonURL.appendingPathComponent(name)
        
        var request = URLRequest(url: pokemonURLName)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error reciving animal data wiht \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
                return
            }
            guard let data = data else {
                print("No data received from getAllAnimals")
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Erorr decoding pokemon with error: \(error)")
                completion(.failure(.tryAgain))
                return
            }
        }
        task.resume()
        
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let imageURL = URL(string: urlString) else { completion(.failure(.noData)); return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _ , error) in
            if let error = error {
                print("Error receiving pokemon image with error \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }
        task.resume()
    }
    
    func addPokimon(pokemons: Pokemon) {
        let newPokemon = Pokemon(id: pokemons.id, name: pokemons.name, abilities: pokemons.abilities, types: pokemons.types, sprites: pokemons.sprites)
        pokemon.append(newPokemon)
        print(newPokemon)
        saveToPersistentStore()
    }
    
    func deletePokemon(pokemons: Pokemon) {
        guard let index = pokemon.firstIndex(of: pokemons) else { return }
        pokemon.remove(at: index)
        print(pokemons)
        saveToPersistentStore()
    }
    
    // MARK: Persistant
    
    private var pokemonListURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = "PokemonList.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    private func loadFromPersistentStore() {
            
           
        
        
        do {
            guard let fileURL = pokemonListURL else { return }
          
            
            let pokemonData = try Data(contentsOf: fileURL)
           
            print(pokemonData)
            
            let plistDecoder = PropertyListDecoder()

            
            self.pokemon = try plistDecoder.decode([Pokemon].self, from: pokemonData)
           
        } catch {
            NSLog("Error decoding memories from property list: \(error)")
        }
    }
    
    private func saveToPersistentStore() {
        
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        
        do {
            let pokemonData = try plistEncoder.encode(pokemon)
            
            guard let fileURL = pokemonListURL else { return }
            
            try pokemonData.write(to: fileURL)
        } catch {
            NSLog("Error encoding memories to property list: \(error)")
        }
    }
}

