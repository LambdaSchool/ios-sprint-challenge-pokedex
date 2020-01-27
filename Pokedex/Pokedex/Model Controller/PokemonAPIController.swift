//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Eoin Lavery on 27/01/2020.
//  Copyright © 2020 Eoin Lavery. All rights reserved.
//

import Foundation
import UIKit

enum HTTPRequest: String {
    case GET
}

class PokemonAPIController {
    
    //API Properties
    let baseUrl: String = "https://pokeapi.co/api/v2/pokemon/"
    var localStorageUrl: URL? {
        let fileManager = FileManager()
        guard let pokemonList = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return pokemonList.appendingPathComponent("Pokemon.plist")
    }
    
    //Array to store results
    var searchResults: [Pokemon] = []
    var savedPokemon: [Pokemon] = []
    
    init() {
        loadPokemonFromPersistentStore()
    }
    
    func getPokemonSprite(with url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        //Ensure image URL is valid
        guard let imageUrl = URL(string: url) else {
            print("Error with image URL")
            completion(nil, NSError())
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, _, error) in
            //Check for errors from URL image fetch
            guard error == nil else {
                print("Error retrieving image from URL")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error locating image data with supplied URL")
                completion(nil, error)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error creating UIImage from data")
                completion(nil, error)
                return
            }
            
            completion(image, nil)
            
        }.resume()
    }
    
    func searchForPokemon(with name: String, completion: @escaping (Error?) -> Void) {
        
        //Empty search results array when intiating new search
        searchResults = []
        
        //Ensure that URL is valid
        guard let baseUrl = URL(string: baseUrl)?.appendingPathComponent(name) else {
            print("Error establishing URL for API call.")
            return
        }
        
        //Create URLRequest
        var request = URLRequest(url: baseUrl)
        request.httpMethod = HTTPRequest.GET.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //Check for errors in API Call
            guard error == nil else {
                print("Error when contacting API: \(String(describing: error))")
                completion(error)
                return
            }
            
            //Check to ensure data has been downloaded from API
            guard let data = data else {
                print("Error retrieving data from API: \(String(describing: error))")
                completion(error)
                return
            }
            
            //Decode JSON Data
            let jsonDecoder = JSONDecoder()
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                self.searchResults.append(pokemon)
                completion(nil)
            } catch {
                print("Error decoding data from API: \(error)")
                completion(error)
            }
            
        }.resume()
        
    }
    
    func savePokemonToPersistentStore(for pokemon: Pokemon) {
        guard let url = localStorageUrl else { return }
        savedPokemon.append(pokemon)
        let encoder = PropertyListEncoder()
        
        do {
            let pokemonData = try encoder.encode(savedPokemon)
            try pokemonData.write(to: url)
        } catch {
            print("Error saving Pokemon to local storage")
        }
    }
    
    func loadPokemonFromPersistentStore() {
        let fm = FileManager.default
        guard let url = localStorageUrl, fm.fileExists(atPath: url.path) else { return }
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data.init(contentsOf: url)
            let decodedPokemon = try decoder.decode([Pokemon].self, from: data)
            savedPokemon = decodedPokemon
        } catch {
            print("Error loading Pokemon Data")
        }
    }
    
}
