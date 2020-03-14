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
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    private let imageURL = URL(string: "http://pokeapi.co/media/sprites/pokemon")!
    
    var pokemons: [Pokemon] = []
    var pokemon: Pokemon!
    
    func addPokemon(withName name: String, id: Int, ability: Abilities, type: Type, image: Image) {
        let pokemon = Pokemon(name: name, id: id, ability: [ability], type: [type], image: image)
        pokemons.append(pokemon)
    }
    
    func pokemonSearch(searchTerm: String, completion: @escaping (Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "name", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        guard let requestURL = urlComponents?.url else {
            NSLog("request URL is nil")
            return
            
        }
        //        let pokemonNameURL = baseURL.appendingPathComponent("\(pokemon.name)")
        var request = URLRequest(url: requestURL)
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
                let pokemonSearch = try jsonDecoder.decode(PokemonSearchResults.self, from: data)
                self.pokemons.append(contentsOf: pokemonSearch.results)
                
            } catch {
                NSLog("Unable to decode data into object of type [Pokemon]: \(error)")
                completion(error)
            }
        }.resume()
    }
    
    func pokemonImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        //        let imageUrl = baseURL.appendingPathComponent("\(pokemon.id).png")
        if pokemon != nil {
            guard let imageUrl = URL(string: "\(urlString)\(pokemon.id).png") else {
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


