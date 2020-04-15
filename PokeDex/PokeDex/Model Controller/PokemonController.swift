//
//  PokemonController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    typealias GetImageCompletion = (Result<UIImage, NetworkError>) -> Void
    typealias GetPokemonCompletion = (Result<Pokemon, NetworkError>) -> Void
    
    enum NetworkError: Error {
        case failedFetch
        case badData
        case noDecode
        case badURL
    }
    
    var pokemon: Pokemon!
    var pokemons: [Pokemon] = []
    private let searchBar = UISearchBar()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    private let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon")!
    private var task: URLSessionTask?
    
    
    func searchForPokemon(for searchTerm: String, completion: @escaping GetPokemonCompletion) {
        task?.cancel()
        let searchTerm = searchBar.text?.lowercased() ?? ""
        
        
        let pokemonNameURL = baseURL.appendingPathComponent("/pokemon/\(searchTerm)")
        var request = URLRequest(url: pokemonNameURL)
        request.httpMethod = "GET"
        
        task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return completion(.failure(.failedFetch))
            }
            
            guard let self = self else { return }
            
            guard let data = data else {
                print("No data returned from dataTask")
                return completion(.failure(.badData))
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                self.pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
//                self.pokemon = pokemonSearchResults.result
                completion(.success(self.pokemon))
//                print(self.pokemon)
                
            } catch {
                print("Unable to decode data into instance of Pokemon: \(error)")
                completion(.failure(.noDecode))
            }
            
        }
        task?.resume()
        
    }
    
    func fetchImage(at urlString: String, completion: @escaping GetImageCompletion) {
        let pokemonId = "/\(pokemon.id ?? 0).png"
        let urlString = imageURL.appendingPathComponent(pokemonId)
        
//        if pokemon != nil {
        guard let imageURL = URL(string: "\(urlString)") else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print("Failed to fetch pokemon image with error \(error.localizedDescription)")
                return completion(.failure(.failedFetch))
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    print(#file, #function, #line, "Fetch pokemon image received bad response") //
                    return completion(.failure(.failedFetch))
            }
            
            guard let data = data,
                let image = UIImage(data: data)
                else {
                    return completion(.failure(.badData))
            }
            
            completion(.success(image))
        }.resume()
     
    }
    
    
}

