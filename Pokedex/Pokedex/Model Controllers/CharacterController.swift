//
//  CharacterController.swift
//  Pokedex
//
//  Created by morse on 5/10/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

class CharacterController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var characters: [Character] = []
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    func searchForCharacters(with searchTerm: String, completion: @escaping () -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "", value: searchTerm)
        
        urlComponents?.queryItems = [searchTermQueryItem]
        guard let requestURL = urlComponents?.url else {
            NSLog("requestURL is nil")
            completion()
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let characterSearch = try jsonDecoder.decode(CharacterSearch.self, from: data)
                self.characters = characterSearch.results
            } catch {
                NSLog("Unable to decode data into object of type [Character]: \(error)")
            }
            print(requestURL)
            completion()
            }.resume()
    }
}
