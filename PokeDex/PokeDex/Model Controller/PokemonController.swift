//
//  PokemonController.swift
//  PokeDex
//
//  Created by Nichole Davidson on 4/10/20.
//  Copyright © 2020 Nichole Davidson. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    enum NetworkError: Error {
        case otherError
        case badData
        case noDecode
        case badURL
    }
    
    var pokemon = Pokemon()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    private var task: URLSessionTask?
    
    
    func searchForPokemon(searchTerm: String, completion: @escaping () -> Void) {
        task?.cancel()
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
                   if let error = error {
                       print("Error fetching data: \(error.localizedDescription)")
                       return
                   }
                   
                   guard let self = self else { return }
                   
                   guard let data = data else {
                       print("No data returned from dataTask")
                       return
                   }
                   
                   let jsonDecoder = JSONDecoder()
                   
                   do {
                       let pokemonSearchResults = try jsonDecoder.decode(PokemonSearchResults.self, from: data)
                       self.pokemon = pokemonSearchResults.results
                   } catch {
                       print("Unable to decode data into instance of PersonSearch: \(error.localizedDescription)")
                   }
                   
                   completion()
               }
               
               task?.resume()
           }
    
}

