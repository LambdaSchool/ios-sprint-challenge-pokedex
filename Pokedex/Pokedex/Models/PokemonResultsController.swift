//
//  PokemonResultsController.swift
//  Pokedex
//
//  Created by Marissa Gonzales on 5/8/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError(Error)
    case noData
    case decodeFailed
    case noImage
}

class PokemonResultsController {

    // MARK: - Properties
    var savedPokemon: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    // MARK: Functions
    
    // Get the Pokemon based on search
    func getPokemon(with pokemon: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {

        let getPokemonURL = baseURL.appendingPathComponent("pokemon/\(pokemon.lowercased())")

        var request = URLRequest(url: getPokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue

        //Request data
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            //Decode the data
            let decoder = JSONDecoder()
            do {
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(.decodeFailed))
            }

        }.resume()
    }

    // Fetch Image
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.noImage))
            return
        }

        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.otherError(error!)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            guard let image = UIImage(data: data) else {
                completion(.failure(.noImage))
                return
            }

            completion(.success(image))

        }.resume()
    }
}
