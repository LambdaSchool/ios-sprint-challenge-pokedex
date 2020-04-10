//
//  PokemonController.swift
//  PokemonApp
//
//  Created by Bhawnish Kumar on 4/10/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation
import UIKit
enum NetworkError: Error {
    case otherError(Error)
    case noData
    case decodeFailed
}

class APIController {
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
    
    func getPokemon(_ query: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let url = baseUrl.appendingPathComponent("pokemon/\(query.lowercased())")
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodeFailed))
            }
        }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageUrl = URL(string: urlString)!
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
}
