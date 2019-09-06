//
//  APIController.swift
//  iOS Sprint Challenge Pokedex
//
//  Created by Andrew Ruiz on 9/6/19.
//  Copyright © 2019 Andrew Ruiz. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError(Error)
    case noData
    case noDecode
    case noToken
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class APIController {
    
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/houndoom")!
    
    func getPokemon(with name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
    }
}
