//
//  PokemonController.swift
//  PokedexSprintProject
//
//  Created by BrysonSaclausa on 7/18/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

class PokemonController{
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData
        case tryAgain
    }
    
    var baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    
}
