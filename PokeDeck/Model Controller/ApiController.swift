//
//  ApiController.swift
//  PokeDeck
//
//  Created by Austin Potts on 9/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum HTTPMethod: String{
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    
}

enum NetworkError: Error{
    case ecodingError
    case responseError
    case otherError(Error)
    case noData
    case noDecode
    case noToken
}

class APIControler {
    
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
   
    
    func searchForPokemon(with searchTerm:String, completion: @escaping () -> Void){
        
        let pokemonURL = baseURL.appendingPathComponent("pokemon")
        
        var components = URLComponents(url: pokemonURL, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchItem]
        
        //Ask the components to give us the formatted URL from the parts we gvce it
        guard let requestURL = components?.url else{
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //The data task hasnt gone to the API yet
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            //The data task has gone to the API and come back with data, response and error from API
            
            //Check for an error
            if let error = error{
                NSLog("Error Searching people: \(error)")
            }
            
            //See if there is data
            guard let data = data else {
                NSLog("No data")
                completion()
                return
            }
            
            //Decode the data
            do {
                let decoder = JSONDecoder()
                
                let pokemonSearch = try decoder.decode(PokemonResult.self, from: data)
                
                self.pokemon = pokemonSearch.results
                
            } catch {
                NSLog("Error Decoding from data: \(error)")
            }
            completion()
            
            }.resume()
    }
    
    func getAllPokemonNames(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        
       
        
        let requestURL = baseURL.appendingPathComponent("pokemon")
            .appendingPathComponent("all")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        
        URLSession.shared.dataTask(with: request){(data,response,error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.responseError))
                return
            }
            
            if let error = error {
                NSLog("Error getting Pokemon names: \(error)")
                completion(.failure(.otherError(error)))
                return
            }
            
            
            guard let data = data else{
                completion(.failure(.noData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let animalNames = try decoder.decode([String].self, from: data)
                completion(.success(animalNames))
            } catch {
                NSLog("Error decoding Pokemon name: \(error)")
                completion(.failure(.noDecode))
                return
                
                
            }
            
            }.resume()
    }
    
    
    
    
    
}
