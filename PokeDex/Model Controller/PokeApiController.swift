//
//  PokeApiController.swift
//  PokeDeckCheat
//
//  Created by Austin Potts on 9/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class APIControler {
    
    var pokemon: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    //Completion
    typealias CompletionHandler = (Error?) -> Void
    
    func getPokemon(completion: @escaping CompletionHandler = {_ in}) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error Getting Users: \(error)")
            }
            guard let data = data else {
                NSLog("No Data Returned From Data Task.")
                completion(nil)
                return
            }
            do {
                let newPokemon = try JSONDecoder().decode(PokemonResult.self, from: data)
                print(newPokemon)
                self.pokemon = newPokemon.results
            } catch {
                NSLog("Error decoding Users: \(error)")
                completion(error)
            }
            completion(nil)
            }.resume()
    
    }
    
    
    
    func searchForPokemon(with searchTerm:String, completion: @escaping CompletionHandler = {_ in}){
        
        let peopleURL = baseURL.appendingPathComponent("people")
        
        var components = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)
        
        let searchItem = URLQueryItem(name: "search", value: searchTerm)
        
        components?.queryItems = [searchItem]
        
        //Ask the components to give us the formatted URL from the parts we gvce it
        guard let requestURL = components?.url else{
            completion(nil)
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
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
                completion(nil)
                return
            }
            
            //Decode the data
            do {
                let decoder = JSONDecoder()
                
                let pokemonSearch = try decoder.decode(PokemonSearch.self, from: data)
                
                self.pokemon = pokemonSearch.results
                
            } catch {
                NSLog("Error Decoding from data: \(error)")
            }
            completion(nil)
            
            }.resume()
        
        
        enum HTTPMethod: String{
            case get = "GET"
            case put = "PUT"
            case post = "POST"
            case delete = "DELETE"
        }

    }
    
    
}
