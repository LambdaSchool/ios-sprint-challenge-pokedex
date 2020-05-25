//
//  APIController.swift
//  Pokedex
//
//  Created by Clean Mac on 5/18/20.
//  Copyright © 2020 LambdaStudent. All rights reserved.
//

import Foundation

struct PokemonController: Decodable {
    
    var pokemonList: [Pokemon] = []
    
    
    enum HTTPMethod: String {
        case get = "GET"
       
    }
    
    private let pokemonURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    func searchForPokemonWith(searchTerm: String, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: pokemonURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = URLComponents?.url else {
            print("request URL is nill")
            completion
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { ([weak self] data, _, error) in
            if let error = error {
                print("fetching data error: \(error) ")
                completion()
                return
            }
            guard let self = self else {completion(); return}
            
            guard let data = data else {
                print("no data returned from data task")
                completion()
                return
            }
            let jsonDecoder = JSONDecoder
            
        }
        
    }
 
}
