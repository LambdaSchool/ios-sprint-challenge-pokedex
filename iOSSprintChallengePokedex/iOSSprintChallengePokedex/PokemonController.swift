//
//  PokemonController.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import Foundation

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
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    var pokemons: [Pokemon] = []
    
    func fetchPokemon(for name: String, completion: @escaping (Pokemon, Error) -> Void){
        let url = baseURL.appendingPathComponent(name)
        let request = URLRequest(url: url)
    }

}
