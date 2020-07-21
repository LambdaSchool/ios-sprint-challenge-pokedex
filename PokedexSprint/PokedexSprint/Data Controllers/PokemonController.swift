//
//  PokemonController.swift
//  PokedexSprint
//
//  Created by John McCants on 7/17/20.
//  Copyright © 2020 John McCants. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    //Controller to handle the networking request
    enum HTTPMethod: String {
        case get = "GET"
    }

    enum NetworkError: Error {
        case noData
        case tryAgain
        case noImage
    }
    var baseURL = URL(string: "https://pokeapi.co/api/v2")!
    var pokemonResults : [PokemonSearchResult] = []
    
    //Search Function
    func searchPokemon(searchText: String, completion: @escaping (Result<PokemonSearchResult, NetworkError>) -> Void) {
        
        let searchURL = baseURL.appendingPathComponent("pokemon/\(searchText)")
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //Handle Error
            if let error = error {
                print("Error \(error)")
                completion(.failure(.noData))
            }
            
            //Handle Response
            if let response = response {
                print("Response error")
                completion(.failure(.noData))
            }
            
            //Handle Data
            guard let data = data else {
                completion(.failure(.noData))
                return}
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let pokemonResult = try jsonDecoder.decode(PokemonSearchResult.self, from: data)
                completion(.success(pokemonResult))
                print("successfully decoded pokemon result")
            } catch {
                print("Unable to decode the pokemon \(searchText)")
                completion(.failure(.tryAgain))
            }
            } .resume()
 
    }

    func fetchSprite(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            print("unable to get image url")
            completion(.failure(.noImage)); return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(.failure(.noImage))
                return
            }
            
            guard let imageData = data else {
                print("unable to get image data")
                completion(.failure(.noData))
                return
            }
            
            if let image = UIImage(data: imageData) {
                print("we got the image")
                completion(.success(image))
            } else {
                print("we didn't get the image")
                completion(.failure(.noImage))
                return
            }
        } .resume()
        
    }
    
}

