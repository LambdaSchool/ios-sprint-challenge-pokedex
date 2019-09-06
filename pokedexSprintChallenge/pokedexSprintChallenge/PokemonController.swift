//
//  PokemonController.swift
//  pokedexSprintChallenge
//
//  Created by admin on 9/6/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError
    case noData
    case noDecode
}

class PokemonController {
    
    var bearer: Bearer?
    
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    typealias CompletionHandler = (Error?) -> Void
    
    
    
    
    
}
