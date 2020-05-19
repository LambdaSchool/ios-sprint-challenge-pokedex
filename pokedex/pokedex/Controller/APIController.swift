//
//  APIController.swift
//  pokedex
//
//  Created by Sammy Alvarado on 5/17/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation

class APIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/4")!
    var searchResults: [SearchResult] = []
    
    enum HTTPMethod: String {
        case get = "Get"
        case post = "Post"
    }
    
    enum NetworkError: Error {
        
    }

    
}


