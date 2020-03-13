//
//  PokemonController.swift
//  Pokedex
//
//  Created by Lydia Zhang on 3/13/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case badUrl
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}



class PokemonController {
    
    init() {
        loadFromPersistent()
    }
    
    private var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    var pokemonArray: [Pokemon] = []
    
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        let baseUrl = baseURL.appendingPathComponent(name.lowercased())
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            
            if let error = error {
                NSLog("\(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("Server responded with no data to decode.sup")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                NSLog("Decode error: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchPokemonImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageUrl = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error receiving animal image data: \(error)")
                completion(.failure(.otherError))
                return
            }
        
            guard let data = data else {
                NSLog("GitHub responded with no image data.")
                completion(.failure(.badData))
                return
            }
        
            guard let image = UIImage(data: data) else {
                NSLog("Image data is incomplete or corrupted.")
                completion(.failure(.badData))
                return
            }
            completion(.success(image))
        }.resume()
    }
    
    
    var pokemonURL: URL? {
        let fm = FileManager.default
        guard let pokemon = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return pokemon.appendingPathComponent("pokemonList.plist")
    }
    
    func saveToPresistent(){
        guard let url = pokemonURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemonArray)
            try data.write(to: url)
        } catch {
            print("Saving error.")
        }
    }
    func loadFromPersistent(){
        guard let url = pokemonURL else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.pokemonArray = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Decode error.")
        }
    }
    
    func deletePokemon(for pokemon: Pokemon) {
        guard let index = pokemonArray.firstIndex(of: pokemon) else {return}
        pokemonArray.remove(at: index)
        saveToPresistent()
    }
    func savePokemon(for pokemon: Pokemon){
        let pokemon = Pokemon(id: pokemon.id, name: pokemon.name, abilities: pokemon.abilities, types: pokemon.types, sprites: pokemon.sprites)
        pokemonArray.append(pokemon)
        saveToPresistent()
    }
    
    
}
