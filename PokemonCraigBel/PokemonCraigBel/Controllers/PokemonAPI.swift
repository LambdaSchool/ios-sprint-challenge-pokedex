//
//  PokemonAPI.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation
import UIKit

final class PokemonController {
    
    enum HTTPMethod: String {
        case get = "GET"
        // case post = "POST"
    }
    
    enum NetworkError: Error {
        case noData
        case noToken
        case tryAgain
    }
    
    enum Keys: String, CodingKey {
              case name
              case id
              case abilities
              case type
              case image
              
              enum AbilityDescriptionKeys: String, CodingKey {
                  case ability
                  
                  enum AbilityKeys: String, CodingKey {
                      case name
                  }
              }
              enum TypeDescriptionKeys: String, CodingKey {
                  case type
                  
                  enum TypeKeys: String, CodingKey {
                      case name
                  }
              }
          }
    
    var pokemonA: [Pokemon] = []
    var bearer: Bearer?
    
    private let baseURL = URL(string: "https://lambdapokeapi.herokuapp.com/api")!
    private lazy var pokemonSearchURL = baseURL.appendingPathComponent("/v2/pokemon/")
    
    let name: String
    let id: Int
    let abilities: [String]
    let types: [String]
    let image: String
      
        init(decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            
            name = try container.decode(String.self, forKey: .name)
            
            // i know i have to fix the int
            id = try container.decode(Int.self, forKey: .id)
            
            image = try container.decode(String.self, forKey: .image)
            
            var abiltiesContainer = try container.nestedUnkeyedContainer(forKey: .abilities)
            
            var abilityNames: [String] = []
            
            var typeContainer = try container.nestedUnkeyedContainer(forKey: .type)
            
            var typeNames: [String] = []
            
            while abiltiesContainer.isAtEnd == false {
                
                let AbilityDescriptionContainer = try abiltiesContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.self)
                
                let abilityContainer = try AbilityDescriptionContainer.nestedContainer(keyedBy: Keys.AbilityDescriptionKeys.AbilityKeys.self, forKey: .ability)
                
                let abilityName = try abilityContainer.decode(String.self, forKey: .name)
                abilityNames.append(abilityName)
                
                while typeContainer.isAtEnd == false {
                    
                    let TypeDescriptionContainer = try typeContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.self)
                    
                    let typeContainer = try TypeDescriptionContainer.nestedContainer(keyedBy: Keys.TypeDescriptionKeys.TypeKeys.self, forKey: .type)
                    
                    let typeName = try typeContainer.decode(String.self, forKey: .name)
                    typeNames.append(typeName)
                    
                }
            }
            
            abilities = abilityNames
            types = typeNames
            
        }
    

    
    func searchPokemon(for pokemonNames: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let bearer = bearer else {
            completion(.failure(.noToken))
            return
        }
        var request = URLRequest(url: pokemonSearchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print ("\(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(.failure(.noData))
                return
            }
            
            do {
                let pokemonNames = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemonNames))
            } catch {
                print("Error \(error)")
                completion(.failure(.tryAgain))
            }
            
        }
        task.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
           let imageURL = URL(string: urlString)!
           
           var request = URLRequest(url: imageURL)
           request.httpMethod = HTTPMethod.get.rawValue
           
           let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
               if let error = error {
                   print("Error: \(error)")
                   completion(.failure(.tryAgain))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(.noData))
                   return
               }
               
               let image = UIImage(data: data)!
               completion(.success(image))
               
           }
           task.resume()
       }
   
}
