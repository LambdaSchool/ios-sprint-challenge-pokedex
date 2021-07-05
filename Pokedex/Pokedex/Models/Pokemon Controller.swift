//
//  Pokemon Controller.swift
//  Pokedex
//
//  Created by Vuk Radosavljevic on 8/10/18.
//  Copyright © 2018 Vuk. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!


class PokemonController {
    
    //MARK: - Properties
    private(set) var pokemon = [Pokemon]()
    var aPokemon: Pokemon?
    
    
    //MARK: - Methods
    
    func delete(thePokemon: Pokemon) {
        guard let index = pokemon.index(of: thePokemon) else {return}
        pokemon.remove(at: index)
    }
    
    func savePokemon() {
        guard let aPokemon = aPokemon else {return}
        pokemon.append(aPokemon)
    }
    
    
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let url = baseURL.appendingPathComponent(searchTerm).appendingPathExtension("json")
        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { (data, _ , error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let decodedEntries = try jsonDecoder.decode(Pokemon.self, from: data)
                print(decodedEntries)
                self.aPokemon = decodedEntries
                completion(decodedEntries, nil)
            } catch {
                NSLog("Error decoding recieved data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
