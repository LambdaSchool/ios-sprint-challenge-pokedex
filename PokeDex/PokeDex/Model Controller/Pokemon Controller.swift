//
//  Pokemon Controller.swift
//  PokeDex
//
//  Created by Nichole Davidson on 3/13/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
    case badUrl
}

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    private let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon")!
    private var searchBar = UISearchBar()
    
    var pokemons = [Pokemon]()
    var pokemon: Pokemon?
    
    func addPokemonToList(with pokemonName: Pokemon) {
        let newPokemon = pokemonName
//        pokemons.append(newPokemon)
        print(newPokemon)
        
    }

    
    func pokemonSearch(for searchTerm: String, completion: @escaping (Error?) -> Void) {
        let searchTerm = searchBar.text?.lowercased() ?? ""
        
        let pokemonNameURL = baseURL.appendingPathComponent(searchTerm)
        var request = URLRequest(url: pokemonNameURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                print(pokemonSearch)
                self.pokemons.append(pokemonSearch)
                
            } catch {
                NSLog("Unable to decode data into object of type [Pokemon]: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func pokemonImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        let urlString = baseURL.appendingPathComponent("\(pokemon?.id).png")
        if pokemon != nil {
            guard let imageUrl = URL(string: "\(urlString)") else {
                completion(.failure(.badUrl))
                return
            }
            
            var request = URLRequest(url: imageUrl)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    NSLog("Error receiving pokemon image data: \(error)")
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
    }
}


