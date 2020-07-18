//
//  PokemonController.swift
//  Pokemon
//
//  Created by Cora Jacobson on 7/18/20.
//  Copyright © 2020 Cora Jacobson. All rights reserved.
//

import UIKit

class PokemonController {
    
    init() {
        loadFromPersistentStore()
    }
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum NetworkError: Error {
        case noData
        case tryAgain
    }
    
    var pokemonArray: [Pokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func getPokemon(_ searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let searchURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving Pokemon data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 404 {
                    completion(.failure(.noData))
                    return
                }
                if response.statusCode != 200 {
                    print(response)
                    completion(.failure(.tryAgain))
                    return
                }
            }
            guard let data = data else {
                print("No data received from getPokemon")
                completion(.failure(.noData))
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error decoding Pokemon data: \(error)")
                completion(.failure(.tryAgain))
            }
        }
        task.resume()
    }
    
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        let imageURL = URL(string: urlString)!
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving pokemon image: \(urlString), error: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            guard let data = data else {
                print("No data received from fetchImage")
                completion(.failure(.noData))
                return
            }
            let image = UIImage(data: data)!
                completion(.success(image))
        }
        task.resume()
        }
    
    // MARK: Persistence
    
    struct PokemonPersistence: Codable {
        var name: String
        var id: Int
        var types: [String]
        var abilities: [String]
        var imageString: String
    }
    
    private var pokemonURL: URL? {
        let fm = FileManager.default
        let filename = "pokemon.plist"
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent(filename)
    }

    func saveToPersistentStore() {
        guard let url = pokemonURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(pokemonArray)
            try data.write(to: url)
        } catch {
            NSLog("Was not able to encode data: \(error)")
        }
    }

    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = pokemonURL,
        fm.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let plistDecoder = PropertyListDecoder()
            let decodedPokemon = try plistDecoder.decode([PokemonPersistence].self, from: data)
            for pokemon in decodedPokemon {
                let mon = Pokemon(pokemon.name, pokemon.id, pokemon.types, pokemon.abilities, pokemon.imageString)
                pokemonArray.append(mon)
            }
        } catch {
            NSLog("No data was saved: \(error)")
        }
    }
    
}
