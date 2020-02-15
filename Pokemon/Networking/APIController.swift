//
//  APIController.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
         case get = "GET"
         case put = "PUT"
         case post = "POST"
         case delete = "DELETE"
     }
     enum NetworkError : Error {
         case badURL
         case requestFailed
         case Unknown
     }
   
class APIController  {
    
    
     var pokemons = [Pokemon]()
    
    init() {
           loadFromPersistentStore()
       }
       
    func createPokemon(with pokemon: Pokemon) {
        
        pokemons.append(pokemon)
        
        saveToPersistentStore()
    }
    
    func deletePokemon(with pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(of: pokemon) else { return }

             pokemons.remove(at: index)
             
             saveToPersistentStore()
    }
    
    
    var pokemonNames = [PokemonName]()
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemon = Pokemon(id: 0, name: "",  image: nil,types: [],abilities: [] )

    func performSearch(searchTerm: String,completion: @escaping (Error?) -> Void) {

           
        let allPokemonURL = baseURL.appendingPathComponent(searchTerm.lowercased())
         
           
           var request = URLRequest(url: allPokemonURL)
           request.httpMethod = HTTPMethod.get.rawValue
           
           print(request)
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   NSLog("Error fetching data: \(error)")
                   completion(NetworkError.requestFailed)
               }
               guard response != nil else {
                   NSLog("Error getting response from JSON")
                   return
               }
               guard let data = data else {
                   completion(NetworkError.Unknown)
                   NSLog("Can't fetch data")
                   return
               }
               
               let jsonDecoder = JSONDecoder()
               do {
                   let pokemonSearch = try jsonDecoder.decode(Pokemon.self, from: data)
                     self.pokemon = pokemonSearch
                   completion(nil)
               } catch let err {
                   NSLog("Can't decode data :\(err.localizedDescription)")
               }
               completion(nil)
           }
           .resume()
           
       }
    
    
   func fetchAllNames(completion: @escaping (Result<PokemonNames, NetworkError>) -> Void) {
          
    var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    
    let limitSearch = URLQueryItem(name: "limit", value: "964")
    urlComponents?.queryItems = [limitSearch]
  
    guard let requestURL = urlComponents?.url else {
             NSLog("URL is nil")
              
               return
           }
    
    var request = URLRequest(url: requestURL)
    
             request.httpMethod = HTTPMethod.get.rawValue
           
             URLSession.shared.dataTask(with: request) { (data, response, error) in
                 if let error = error {
                     NSLog("Error receiving gigs data: \(error)")
                    completion(.failure(.Unknown))
                     return
                 }
                 if let response = response as? HTTPURLResponse,
                     response.statusCode == 401 {
                    completion(.failure(.requestFailed))
                     return
                 }
                 guard let data = data else {
                    completion(.failure(.Unknown))
                     return
                 }
                 let decoder = JSONDecoder()
                
                 do {
                    let name = try decoder.decode(PokemonNames.self, from: data)
                  
                    completion(.success(name))
                  
                 } catch {
                     NSLog("Error decoding gigs object: \(error)")
                    completion(.failure(.Unknown))
                     return
                 }
             }.resume()
         }
    
   
    private func loadFromPersistentStore() {
           
           do {
               guard let fileURL = pokemonURL else { return }
               
               let notebooksData = try Data(contentsOf: fileURL)
               
               let plistDecoder = PropertyListDecoder()
               
               self.pokemons = try plistDecoder.decode([Pokemon].self, from: notebooksData)
           } catch {
               NSLog("Error decoding memories from property list: \(error)")
           }
       }
       
       private func saveToPersistentStore() {
           
           let plistEncoder = PropertyListEncoder()
           
           do {
               let pokemonsData = try plistEncoder.encode(pokemons)
               
               guard let fileURL = pokemonURL else { return }
               
               try pokemonsData.write(to: fileURL)
           } catch {
               NSLog("Error encoding memories to property list: \(error)")
           }
       }
       
       // MARK: - Properties
       
       private var pokemonURL: URL? {
           let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
           
           let fileName = "Pokemon.plist"
           
           return documentDirectory?.appendingPathComponent(fileName)
       }
    
    func sortAlphabetically() {
          pokemons.sort(by: < )
          saveToPersistentStore()
       }
    
    func sortId() {
        pokemons.sort { (lhs, rhs) -> Bool in
            lhs.id < rhs.id
        }
        saveToPersistentStore()
    }
    
}
