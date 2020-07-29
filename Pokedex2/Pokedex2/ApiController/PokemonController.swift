//
//  PokemonController.swift
//  Pokedex2
//
//  Created by Clean Mac on 7/19/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation
import UIKit

final class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    enum NetworkError: Error {
        case noData
        case tryAgain
        case badUrl
    }
    
    private let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon")!
    
    var savedPokemon: [Pokemon] = []
    
    func fetchPokemon(_ searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let requestUrl = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        // REQUEST
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        //DATA TASK
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("error fetching data: \(error)")
                completion(.failure(.noData))
                return
            }
            guard let data = data else {
                print("no data from data task")
                completion(.failure(.noData))
                return
            }
            
            
            do {
                let pokemonResult = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonResult))
            } catch {
                print("Error decoding pokemon data: \(error)")
                completion(.failure(.noData))
                return
            }
            
        }
        
        task.resume()
        
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error receiving pokemon image: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.tryAgain))
                return
            }
            completion(.success(image))
        }
        
        task.resume()
    }
}


