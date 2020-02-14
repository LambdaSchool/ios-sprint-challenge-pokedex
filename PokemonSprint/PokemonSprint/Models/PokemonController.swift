//
//  PokemonController.swift
//  PokemonSprint
//
//  Created by Elizabeth Wingate on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case otherError
    case badData
    case decodingError
}

class PokemonController {

    // MARK: - Properties

    var pokemonList: [Pokemon] = []
    private let baseUrl = URL(fileURLWithPath: "https://pokeapi.co/api/v2")
    
    
}
