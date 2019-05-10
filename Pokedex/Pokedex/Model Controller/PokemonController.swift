//
//  PokemonController.swift
//  Pokedex
//
//  Created by Christopher Aronson on 5/10/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badResponse
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    var pokemon: [Pokemon] = []
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func search(for poke: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let url = baseUrl.appendingPathComponent(poke)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("Bad Response: \(response.statusCode)")
                completion(.failure(.badResponse))
                return
            }
            
            if let error = error {
                print("Error: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                print("Error with data")
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let search = try decoder.decode(Pokemon.self, from: data)
                print(search)
                completion(.success(search))
            } catch {
                print("Error decoding: \(error)")
                completion(.failure(.noDecode))
                return
            }
            }.resume()
    }
    
    //    func fetchDetails(for animalName: String, completion: @escaping (Result<Animal, NetworkError>) -> Void) {
    //        guard let bearer = bearer else {
    //            completion(.failure(.noAuth))
    //            return
    //        }
    //
    //        let animalUrl = baseUrl.appendingPathComponent("animals/\(animalName)")
    //
    //        var request = URLRequest(url: animalUrl)
    //        request.httpMethod = HTTPMethod.get.rawValue
    //        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
    //
    //        URLSession.shared.dataTask(with: request) { (data, response, error) in
    //            if let response = response as? HTTPURLResponse,
    //                response.statusCode == 401 {
    //                completion(.failure(.badAuth))
    //                return
    //            }
    //
    //            if let _ = error {
    //                completion(.failure(.otherError))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.badData))
    //                return
    //            }
    //
    //            let decoder = JSONDecoder()
    //            decoder.dateDecodingStrategy = .secondsSince1970
    //            do {
    //                let animal = try decoder.decode(Animal.self, from: data)
    //                completion(.success(animal))
    //            } catch {
    //                print("Error decoding animal object: \(error)")
    //                completion(.failure(.noDecode))
    //                return
    //            }
    //            }.resume()
    //    }
    //
    //    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
    //        let imageUrl = URL(string: urlString)!
    //
    //        var request = URLRequest(url: imageUrl)
    //        request.httpMethod = HTTPMethod.get.rawValue
    //
    //        URLSession.shared.dataTask(with: request) { (data, _, error) in
    //            if let _ = error {
    //                completion(.failure(.otherError))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.badData))
    //                return
    //            }
    //
    //            let image = UIImage(data: data)!
    //            completion(.success(image))
    //            }.resume()
    //    }
}
