//
//  APIController.swift
//  Pokedex
//
//  Created by Aaron on 9/14/19.
//  Copyright © 2019 AlphaGrade, INC. All rights reserved.
//

import Foundation

class APIController {
    
    let pokemon: [Pokemon] = []
    
    func fetchDetails(completion: @escaping (Result<Gig, NetworkError>) -> Void) {
        guard let baseURL = baseURL, let bearer = bearer else {
            completion(.failure(.noAuth))
            return
        }
        let gigsURL = baseURL.appendingPathComponent("gigs")
        var request = URLRequest(url: gigsURL)
        request.httpMethod = "GET"
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            if let _ = error {
                completion(.failure(.otherError))
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
                return
            } catch {
                print("Error decoding data. \(error)")
                completion(.failure(.noDecode))
                return
            }
            }.resume()
    }
    
}
