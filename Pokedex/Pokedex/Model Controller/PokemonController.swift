//
//  PokemonController.swift
//  Pokedex
//
//  Created by Nonye on 5/8/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}
enum NetworkError: Error {
    case noData, noDecode, badURL, incompleteData, tryAgain
}

class PokemonController {
    var pokemonArray: [Pokemon] = []
    var pokemonImages: [URL] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
   
    // MARK: - FETCH POKEMON
    func fetchPokemon(name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent(name.lowercased())
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            do {
                let pokemonSearch = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonSearch))
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
            }
        } .resume()
        
    
    // MARK: - FETCH IMAGE FUNCTION
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let error = error {
            print("Error fetching pokemon image: \(error)")
            completion(.failure(.noData))
            return
        }
        guard let data = data else {
            print("No data provided for image: \(error)")
            completion(.failure(.noData))
            return
            }
        guard let image = UIImage(data: data) else {
            print("Data for image is broken")
            completion(.failure(.incompleteData))
            return
                
        }
            completion(.sucess(image))
            .resume
        }
        
        
        // MARK: ADD POKEMON
    func addPokemon(pokemon: Pokemon) {
        pokemonArray.append(pokemon)
        }
        // MARK: DELETE POKEMON
    func delete(pokemon: Pokemon) {
        guard let index = pokemonArray.firstIndex(of: pokemon) else { return }
        pokemonArray.remove(at: index)
        }
    
    
 
    // MARK: - TODO: ADD PERSISTENCE

}
}
}
