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
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class PokemonController {
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    
}
