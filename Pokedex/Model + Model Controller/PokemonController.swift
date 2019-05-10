//
//  PokémonController.swift
//  Pokédex
//
//  Created by Jason Modisett on 9/14/18.
//  Copyright © 2018 Jason Modisett. All rights reserved.
//

import Foundation

class PokémonController {
    
    // MARK:- Init
    init() { loadFromPersistentStore() }
    
    // MARK:- Search
    // Searches for the given Pokémon using the user's entered text
    func searchForPokémon(with searchTerm: String, completion: @escaping (Error?) -> (Void)) {
        let requestUrl = baseUrl.appendingPathComponent("pokemon").appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let _ = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was an error found searching for the given Pokémon: \(error)")
                completion(error)
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let matchedResults = try jsonDecoder.decode(Pokémon.self, from: data)
                self.matchedPokémon = matchedResults
                
                completion(nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
    
    // MARK:- Add to Pokédex
    // Adds the matched Pokémon to the user's saved Pokédex
    func addMatchToPokédex(completion: @escaping (Error?) -> (Void)) {
        guard let match = matchedPokémon else { return }
        
        savedPokémon.append(match)
        savedPokémon.sort {( $0.id < $1.id )}
        saveToPersistentStore()
        completion(nil)
    }
    
    
    // MARK:- Remove Pokémon from Pokédex
    // Removes a given Pokémon from the user's Pokédex
    func removeFromPokédex(pokémon: Pokémon, completion: @escaping(Error?) -> (Void)) {
        guard let index = savedPokémon.index(of: pokémon) else { return }
        
        savedPokémon.remove(at: index)
        saveToPersistentStore()
        completion(nil)
    }
    
    
    // MARK:- Properties & types
    var matchedPokémon: Pokémon?
    private(set) var savedPokémon: [Pokémon] = []
    
    // Base URL for the Pokémon API
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/")!
    
    private var pokémonFileUrl: URL? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileName = "pokédex.plist"
        return directory.appendingPathComponent(fileName)
    }
}


// Adding persistence
extension PokémonController {
    
    // MARK:- Persistent store methods
    // Save data to storage
    private func saveToPersistentStore() {
        do {
            guard let pokémonFileUrl = pokémonFileUrl else { return }
            let plistEncoder = PropertyListEncoder()
            
            let pokémonData = try plistEncoder.encode(savedPokémon)
            
            // Attemping to write the Pokémon data to plist file...
            try pokémonData.write(to: pokémonFileUrl)
            
            // If writing data fails, an error is logged:
        } catch { NSLog("Error encoding shopping items: \(error)") }
    }
    
    // Read data from storage
    private func loadFromPersistentStore() {
        do {
            guard let pokémonFileUrl = pokémonFileUrl,
                FileManager.default.fileExists(atPath: pokémonFileUrl.path) else { return }
            let plistDecoder = PropertyListDecoder()
            
            let pokémonData = try Data(contentsOf: pokémonFileUrl)
            
            self.savedPokémon = try plistDecoder.decode([Pokémon].self, from: pokémonData)
            
            // If decoding data data fails, an error is logged:
        } catch { NSLog("Error decoding shopping items: \(error)") }
    }
    
}
