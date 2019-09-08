//
//  PokedexController.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET" // read only
    case put = "PUT" // create data
    case post = "POST" // update or replace data
    case delete = "DELETE" // delete data
    
}
enum NetworkError: Error {
    
    case encodingErr
    case responseErr
    case otherErr(Error)
    case noData
    case notDecoded
    case noToken
    
}

class PokedexController {
    
    var pokemon: Pokemon?
    
    var pokemons: [Pokemon] = []
    
    static var pokedexController = PokedexController()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func preformSearch(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
       let requestURL = baseURL.appendingPathComponent(searchTerm)
        
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // data task not ran yet
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // check to see that we can connect to the api for search, this is happeneing after the data task has run.
            if let error = error {
                NSLog("Error retrieving searched object: \(error)")
            }
            
            //check to see if we recieved the results from the search
            guard let data = data else {
                NSLog("No data returned from search.")
                completion(.failure(.noData))
                return
            }
            
            // decode the data
            
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
                completion(.success(pokemon))
                
            } catch {
                NSLog("Error retriving the results to your search: \(error)")
                completion(.failure(.notDecoded))
                return
            }
            
            
            }.resume()
        
    }
    
    func createPokemon(name: String, sprites: Sprites, types: [TypeElement], abilities: [Ability], id: Int) {
        let pokemon = Pokemon(name: name, sprites: sprites, types: types, abilities: abilities, id: id)
        pokemons.append(pokemon)
        saveToPersistentStore()
    }
    
//    func deleteBook(name: String, sprites: Sprites, types: [TypeElement], abilities: [Ability], id: Int) {
//        if let index = pokemons.firstIndex(of: po) {
//            books.remove(at: index)
//            saveToPersistentStore()
//        }
//    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = pokemonURL else {return}
        fm.fileExists(atPath: url.path)
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            pokemons = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        guard let url = pokemonURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
    private var pokemonURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return dir.appendingPathComponent("pokemons.plist")
        
    }
}

    
    
    
    

