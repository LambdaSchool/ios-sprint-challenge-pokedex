//
//  PokemonController.swift
//  Pokemon
//
//  Created by Cora Jacobson on 7/18/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData
        case tryAgain
    }
    
    var pokemonArray: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func getPokemon(_ searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let searchURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving Pokemon data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 404 {
                    completion(.failure(.noData))
                    return
                }
                if response.statusCode != 200 {
                    print(response)
                    completion(.failure(.tryAgain))
                    return
                }
            }
            guard let data = data else {
                print("No data received from getPokemon")
                completion(.failure(.noData))
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding Pokemon data: \(error)")
                completion(.failure(.tryAgain))
            }
        }
        task.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving pokemon image: \(urlString), error: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            guard let data = data else {
                print("No data received from fetchImage")
                completion(.failure(.noData))
                return
            }
            let image = UIImage(data: data)!
                completion(.success(image))
        }
        task.resume()
        }
    
}
