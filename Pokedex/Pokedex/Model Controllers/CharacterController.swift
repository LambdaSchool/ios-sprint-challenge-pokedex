//
//  CharacterController.swift
//  Pokedex
//
//  Created by morse on 5/10/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badURL
    case badData
    case badDecode
    case badImageURL
}

class CharacterController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var characters: [Character] = []
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    
    func searchForCharacters(with searchTerm: String, completion: @escaping (Result<Character, NetworkError>) -> Void) {
        
        let characterSearchURL = baseURL.appendingPathComponent(searchTerm)
        var request = URLRequest(url: characterSearchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(.failure(.badData))
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let characterSearch = try jsonDecoder.decode(Character.self, from: data)
                completion(.success(characterSearch))
            } catch {
                NSLog("Unable to decode data into object of type [Character]: \(error)")
                completion(.failure(.badDecode))
            }
            }.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageUrl = URL(string: urlString)!
        
        var request = URLRequest(url: imageUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.badImageURL))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
            }.resume()
    }
}
