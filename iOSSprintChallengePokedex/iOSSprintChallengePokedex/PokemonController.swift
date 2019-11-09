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
    
    func preformSearch(for searchTerm: String, completion: @escaping () -> Void){
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    }

}
