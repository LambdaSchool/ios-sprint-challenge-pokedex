//
//  PokemonController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation
import UIKit

struct PokemonController {
    enum NetworkError: Error {
        case otherError
        case badData
        case noDecode
        case badURL
    }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    
    func searchForPokemon(searchTerm: String, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        URLComponents?.queryItems = searchQueryItem
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
    }
    
}

