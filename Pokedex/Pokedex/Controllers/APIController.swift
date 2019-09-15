//
//  APIController.swift
//  Pokedex
//
//  Created by Aaron on 9/14/19.
//  Copyright © 2019 AlphaGrade, INC. All rights reserved.
//

import Foundation

class APIController {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var pokemon: [Pokemon] = []
    var myPokemon: Pokemon?
    
    func performSearch(searchTerm: String, _: (Error?) -> Void) {
        guard let baseUrl = baseURL else {return}
        let pokeURL = baseUrl.appendingPathComponent("\(searchTerm)")
        print(pokeURL)
        var request = URLRequest(url: pokeURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error Parsing Data: \(error)")
                return
            }
            guard let data = data else {
                print("No Data returned from data task.")
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let searchResults = try jsonDecoder.decode(Pokemon.self, from: data)
                print(searchResults)
                self.myPokemon = searchResults
            } catch {
                print("Hey Dude. Unable to decode into person search object: \(error)")
            }
        }.resume()
    }
    
}
