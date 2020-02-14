//
//  PokemonAPIController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_268 on 2/14/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation


enum HTTPRequest: String {
      case get = "GET"
  }

enum NetworkError: Error {
       case badUrl
       case noAuth
       case badAuth
       case otherError
       case badData
       case noDecode
       case badImage
   }
   

class PokemonAPIController {
    
    
    // MARK: - API Properties
    
    var searchResults: [Pokemon]
    
    var savedPokemon: [Pokemon]
    
    var bearer: Bearer?
    
    var baseURL: String = "https://pokeapi.co/api/v2/pokemon/"
    
    var localPersistanceURL: URL? {
        let fileManager = FileManager()
         guard let pokemonMasterList = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
         return pokemonMasterList.appendingPathComponent("Pokemon.plist")
    }

    
    
    func searchForPokemon(with name: String, completion: @escaping (Result<[Pokemon], NetworkError>) -> Void) {
        var searchResults: [Pokemon] = []
        
        guard let baseURL = URL(string: baseURL)?.appendPathComponent(name) else {
            print("Error")
        }
        
        var request = URLRequest(url: persistance!)
        request.httpMethod = HTTPRequest.get.rawValue
           // This provides authorization credentials to the server.
           // Data here is case sensitve and you must follow the rules exactly.
        request.addValue("Bearer \(bearer!.token)", forHTTPHeaderField: "Authorization")
        
    
   

    
    init() {
        loadFromPersistentStore()
    }
    
    
       // If failure, the bearer token doesn't exist
   
    
       
       
       
       URLSession.shared.dataTask(with: request) { data, response, error in if let error = error {
               NSLog("Error receiving Pokemon data: \(error)")
               completion(.failure(.otherError))
               return
           }
           
           // Specifically, the bearer token is invalid or expired
           if let response = response as? HTTPURLResponse,
               response.statusCode == 401 {
               completion(.failure(.badAuth))
               return
           }
           
           guard let data = data else {
               completion(.failure(.badData))
               return
           }
           
           let decoder = JSONDecoder()
           do {
               let gigs = try decoder.decode([Gig].self, from: data)
                   completion(.success(gigs))
           } catch {
               NSLog("Error decoding [gig] objects \(error)")
               completion(.failure(.noDecode))
               return
           }
           
       }.resume()
}
}
