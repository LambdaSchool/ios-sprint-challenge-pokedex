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
    
    typealias GetImageCompletion = (Result<UIImage, NetworkError>) -> Void
    
    enum NetworkError: Error {
        case failedFetch
        case badData
        case noDecode
        case badURL
    }
    
    var pokemon = Pokemon()
    var pokemons: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    private var task: URLSessionTask?
    
    private lazy var jsonDecoder = JSONDecoder()
    
    
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
                   
                   do {
                    let pokemonSearchResults = try self.jsonDecoder.decode(PokemonSearchResults.self, from: data)
                       self.pokemon = pokemonSearchResults.results
                   } catch {
                       print("Unable to decode data into instance of PokemonSearch: \(error.localizedDescription)")
                   }
                   
                   completion()
               }
               
               task?.resume()
           }
    
    func fetchImage(at urlString: String, completion: @escaping GetImageCompletion) {
        guard let imageURL = URL(string: urlString) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print("Failed to fetch pokemon image with error \(error.localizedDescription)")
                return completion(.failure(.failedFetch))
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    print(#file, #function, #line, "Fetch pokemon image received bad response") //
                    return completion(.failure(.failedFetch))
            }
            
            guard let data = data,
                let image = UIImage(data: data)
                else {
                return completion(.failure(.badData))
            }
            
            completion(.success(image))
        }
            
        .resume()
    }
    
}

