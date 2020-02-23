//
//  PokemonController.swift
//  Pokedex
//
//  Created by Kat Milton on 7/12/19.
//  Copyright © 2019 Kat Milton. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    
}

class PokemonController {
    
    var pokemonList : [Pokemon] = []
    
    private let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon")!
    
    init() {
        loadFromPersistentStore()
    }
    
    func savePokemon(pokemon: Pokemon) {
        pokemonList.append(pokemon)
        saveToPersistentStore()
    }
    
    func deletePokemon(index: Int) {
        pokemonList.remove(at: index)
        saveToPersistentStore()
    }
    func fetchPokemon(for searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting pokemon \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data returned" )
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(nil, error)
                return
            }
            } .resume()
    }
    
    var persistenceURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = documentDirectory.appendingPathComponent("pokemon.plist")
        return fileName
    }
    
    func saveToPersistentStore(){
        guard let url = persistenceURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(pokemonList)
            try data.write(to: url)
        } catch {
            print("Error with plistencoder: \(error)")
            return
        }
    }
    
    func loadFromPersistentStore(){
        let fm = FileManager.default
        guard let url = persistenceURL, fm.fileExists(atPath: url.path) else { return }
        
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data(contentsOf: url)
            let loadedPokemon = try decoder.decode([Pokemon].self, from: data)
            pokemonList = loadedPokemon
        } catch  {
            print("Error with plistencoder: \(error)")
            return
        }
    }
    
}
