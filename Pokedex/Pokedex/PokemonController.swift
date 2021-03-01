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
    
//    private var persistentFileURL: URL? {
//        let fm = FileManager.default
//        guard let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
//        return documents.appendingPathComponent("Pokemon.plist")
//    }
    
    func fetchPokemon(with name: String, completion: @escaping (Error?) -> ()) {
        let searchURL = baseURL.appendingPathComponent("\(name)".lowercased())
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                completion(error)
            }
            
            guard let data = data else {
                completion(NSError(domain: "fetch error with data", code: -1, userInfo: nil))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Pokemon.self, from: data)
                print(result)
                completion(nil)
            } catch {
                completion(error)
            }
            
        }
        
        task.resume()
    }
    
    func save(pokemon: Pokemon) {
        let pokemon = Pokemon(name: pokemon.name, image: pokemon.image, id: pokemon.id, ability: pokemon.ability, types: pokemon.types)
        
        pokemonList.append(pokemon)
    }
}
