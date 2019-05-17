//
//  PokedexController.swift
//  Pokedex
//
//  Created by Jeremy Taylor on 5/17/19.
//  Copyright © 2019 Bytes-Random L.L.C. All rights reserved.
//

import Foundation
import UIKit

class PokedexController {
    
    init() {
        loadFromPersistentStore()
    }
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: [Pokemon] = []
    var savedPokemon: [Pokemon] = []
    var pokemonAPIData: [PokemonAPIData] = []
    
    var abilitiesArray: [String] = []
    var abilitiesString = ""
    var typesArray: [String] = []
    var typesString = ""
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (_ fetchedPokemon: Pokemon?, Error?) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon")
        let searchURL = pokemonURL.appendingPathComponent(searchTerm)
        
        var request = URLRequest(url: searchURL)
        
        
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching from API: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from API")
                completion(nil, NSError())
                return
            }
            
            do {
               let decoder = JSONDecoder()
                let pokemonSearch = try decoder.decode(PokemonAPIData.self, from: data)
                
                for ability in pokemonSearch.abilities {
                    let name = ability.ability.name
                    self.abilitiesArray.append(name)
                    self.abilitiesString = self.abilitiesArray.joined(separator: ",")
                }
                
                for type in pokemonSearch.types {
                    let name = type.type.name
                    self.typesArray.append(name)
                    self.typesString = self.typesArray.joined(separator: ",")
                }
                
                let convertedPokemon = Pokemon(name: pokemonSearch.name, id: pokemonSearch.id, abilities: self.abilitiesString, types: self.typesString, image: pokemonSearch.sprites.front_default )
                self.pokemon.append(convertedPokemon)
                let fetchedPokemon = convertedPokemon
                completion(fetchedPokemon, nil)
            } catch {
                NSLog("Error decoding pokemon from pokemonSearch: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    func savePokemon(pokemon: Pokemon) {
        savedPokemon.append(pokemon)
        saveToPersistentStore()
    }
    
    func delete(pokemon: Pokemon) {
        guard let index = savedPokemon.firstIndex(of: pokemon) else { return }
        savedPokemon.remove(at: index)
        saveToPersistentStore()
        
    }
    
    
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Persistence
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        
        guard let documentsDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("Pokemon.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(savedPokemon)
            try data.write(to: url)
        } catch {
            NSLog("Couldn't save pokemon data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let fm = FileManager.default
            guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedPokemon = try decoder.decode([Pokemon].self, from: data)
            savedPokemon = decodedPokemon
        } catch {
            NSLog("Couldn't load pokemon data: \(error)")
        }
    }
}

extension UIImageView {
    func loadURL(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
