//
//  PokemonController.swift
//  Pokedex
//
//  Created by Craig Belinfante on 1/4/21.
//

import Foundation

class PokemonController {
    enum NetworkError: Error {
        case tryAgain
        case otherError
        case noData
    }
   
//        init() {
//            fetchPokemon(with: pokemon!.name) { (error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
    
    var pokemonList: [Pokemon] = []
    var pokemon: Pokemon?
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        let searchURL = baseURL.appendingPathComponent("\(name)".lowercased())
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                completion(.failure(.tryAgain))
                print("Error \(error)")
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Pokemon.self, from: data)
                print(result)
                completion(.success(result))
            } catch {
                completion(.failure(.otherError))
            }
            
        }
        
        task.resume()
    }
    
    func save(pokemon: Pokemon) {
        let pokemon = Pokemon(name: pokemon.name, image: pokemon.image, id: pokemon.id, ability: pokemon.ability, types: pokemon.types)
        
        pokemonList.append(pokemon)
    }
}
