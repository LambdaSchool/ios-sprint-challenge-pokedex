//
//  PokemonResultController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_204 on 11/1/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class PokemonResultController {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemons: [PokemonResult] = []
    
    func performSearch(for pokemonName: String, completion: @escaping (Result<PokemonResult, Error>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemonName)")

        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(NSError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let pokemonResult = try jsonDecoder.decode(PokemonResult.self, from: data)
                completion(.success(pokemonResult))
            } catch {
                completion(.failure(NSError()))
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(.failure(NSError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NSError()))
            }
        }.resume()
    }
    
    func savePokemon(with pokemon: PokemonResult) {
        pokemons.append(pokemon)
    }
    
    func deletePokemon(_ pokemon: PokemonResult) {
        guard let pokemonIndex = pokemons.firstIndex(of: pokemon) else { return }
        pokemons.remove(at: pokemonIndex)
    }
}
