//
//  PokemonController.swift
//  FlexPokemonSprint
//
//  Created by admin on 10/4/19.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError
    case noData
    case noDecode
}


class PokemonController {
    
    var pokemons: [Pokemon] = []
    
    var pokemon: Pokemon?
    
    init() {
        loadFromPersistentStore()
    }
    
    
    
//    var pokemonController = PokemonController()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
//    func searchForPeople(with searchTerm: String, completion: @escaping () -> Void) {
//        
//        let peopleURL = baseURL.appendingPathComponent(searchTerm)
//        var components = URLComponents(url: peopleURL, resolvingAgainstBaseURL: true)
//        let searchQueryItem = URLQueryItem(name: "search", value: searchTerm)
//        components?.queryItems = [searchQueryItem]
//        guard let requestURL = components?.url else {
//            completion()
//            return
//        }
//        // Create a URLRequest
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        // Perform the request (with a data task)
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // Handle any errors
//            if let error = error {
//                NSLog("Error fetching people: \(error)")
//                completion()
//                return
//            }
//            // (Usually) decode the data
//            guard let data = data else {
//                NSLog("No data returned from person search")
//                completion()
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//                let personSearch = try decoder.decode(Results.self, from: data)
//                self.pokemons = personSearch.results
//            } catch {
//                NSLog("Unable to decode data into PersonSearch: \(error)")
//            }
//            completion()
//        }
//        // This is what performs the data task, or gets it to go to the server
//        dataTask.resume()
//    }
    
    func performSearch(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {

        let requestURL = baseURL.appendingPathComponent(searchTerm)

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                NSLog("Error retrieving searched object: \(error)")
            }

            guard let data = data else {
                NSLog("No data returned from search")
                completion(.failure(.noData))
                return
            }

            do {
               let decoder = JSONDecoder()
               let pokemon = try decoder.decode(Pokemon.self, from: data)
                self.pokemon = pokemon
               completion(.success(pokemon))
            } catch {
                NSLog("Error retrieving search results: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func createPokemon(name: String, sprites: Sprites, types: [TypeElement], abilities: [Ability], id: Int) {
        let pokemon = Pokemon(name: name, sprites: sprites, types: types, abilities: abilities, id: id)
        pokemons.append(pokemon)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = pokemonURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemons)
            try data.write(to: url)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = pokemonURL else { return }
        fm.fileExists(atPath: url.path)
        
        do {
           let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            pokemons = try decoder.decode([Pokemon].self, from: data)
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
     var pokemonURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("pokemons.plist")
    }
    
}
