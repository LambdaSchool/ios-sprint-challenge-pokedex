//
//  SearchResultController.swift
//  Pokedex
//
//  Created by Jarren Campos on 3/20/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case otherError
    case noData
    case badData
}

class SearchResultController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    var searchResults: [Pokemon] = []
    
    func performSearch(searchTerm: String, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        var urlAppended = URL(string: "\(baseURL)/\(searchTerm.lowercased())")
        
        if urlAppended == nil {
            print("Empty search")
            return
        }else {
            var request = URLRequest(url: urlAppended!)
            request.httpMethod = HTTPMethod.get.rawValue
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    NSLog("Error getting data: \(error)")
                    return
                }
                
                guard let data = data else {
                    completion()
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let searchResult = try jsonDecoder.decode(Pokemon.self, from: data)
                    self.searchResults = searchResult.results
                } catch {
                    NSLog("Error unable to decode data: \(error)")
                }
                completion()
            }.resume()
    }

}
}
