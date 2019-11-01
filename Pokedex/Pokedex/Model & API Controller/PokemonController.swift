//
//  PokemonController.swift
//  Pokedex
//
//  Created by Niranjan Kumar on 11/1/19.
//  Copyright © 2019 Nar Kumar. All rights reserved.
//

import Foundation
import UIKit



class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var savedPokemon: [Pokemon] = []
    
    enum HTTPMethod: String {
        case get = "GET"
    }

    enum NetworkError: Error {
        case noAuth
        case badAuth
        case otherError
        case badData
        case noDecode
    }
    


    func getPokemon(named name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void ) {
        let getPokemonURL = baseURL.appendingPathComponent(name)
    
        var request = URLRequest(url: getPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                 response.statusCode != 200 {
                    print("Error w/ response code: (\(response.statusCode))")
                    completion(.failure(.otherError))
                    return
                }
            
            
            if let error = error {
                print("Error fetching pokemon data: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("No data returned from data task")
                completion(.failure(.badData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let aPokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(aPokemon))
            } catch {
                print("Unable to decode data into object of type [SearchResult]: \(error)")
                completion(.failure(.noDecode))
            }
            
        }.resume()
    
    }
    
    
    func getImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void ) {
//        let getImageURL = baseURL.appendingPathComponent(urlString)
        
        guard let getImageURL = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }
        
        var request = URLRequest(url: getImageURL)
        request.httpMethod = HTTPMethod.get.rawValue


        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                print("Error fetching pokemon data: \(error)")
                completion(.failure(.otherError))
                return
            }

            guard let data = data else {
                print("No data returned from data task")
                completion(.failure(.badData))
                return
            }

            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(.otherError))
            }

        }.resume()

    }
    
    
//    func savePokemon(pokemon: Pokemon) {
//        savedPokemon.append(pokemon)
//    }
    
    func deletePokemon(_ pokemon: Pokemon) {
            if let index = savedPokemon.firstIndex(of: pokemon) {
                savedPokemon.remove(at: index)
            }
        }



}



