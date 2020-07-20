//
//  APIController.swift
//  Pokedex
//
//  Created by Sammy Alvarado on 7/20/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation
import UIKit

final class APIController {
    enum HTTPMethod: String {
        case get = "GET"
    }

    enum NetworkError: Error {
        case tryAgain
        case noData
    }

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    func fetchPokemonDetails(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {

        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error failed to fetch pokemon data: \(error)")
                completion(.failure(.tryAgain))
                return
            }

            guard let data = data else {
                print("No data was recieved to the Pokemon Detail view: \(searchTerm) ")
                completion(.failure(.noData))
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error occurred when decoiding Pokemon detail data (Pokemon name = \(searchTerm)): \(error)")
            }
        }
        task.resume()
    }

    func fetchPokemonImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let image = URL(string: urlString)!

        var request = URLRequest(url: image)
        request.httpMethod = HTTPMethod.get.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error failed to recieve Pokemon image: \(urlString), error: \(error)")
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            let image = UIImage(data: data)!
            completion(.success(image))
        }
        task.resume()
    }

}
