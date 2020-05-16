//
//  PokemonController.swift
//  PokedexSprint
//
//  Created by Clayton Watkins on 5/15/20.
//  Copyright © 2020 Clayton Watkins. All rights reserved.
//

import UIKit

class PokemonController {
    
    //MARK: - ENUMS
    enum HTTPMethod: String{
        case get = "GET"
    }
    
    enum NetworkError: Error{
        case noData
        case tryAgain
        case decodeFailed
        case noImage
    }
    
    //MARK: - Properties
    var myPokemon: [Pokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    
    //MARK: - Functions
    //Function to let us search for pokemon with our search parameters, and return decoded JSON data
    func searchForPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void){
        guard let pokemonURL = baseURL?.appendingPathComponent("pokemon/\(searchTerm.lowercased())") else { return }
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(.failure(.tryAgain))
                print("Error getting json: \(error)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(.failure(.tryAgain))
                return
            }
            
            guard let jsonData = data else{
                completion(.failure(.noData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do{
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: jsonData)
                completion(.success(pokemon))
            }catch{
                completion(.failure(.decodeFailed))
            }
        }
        task.resume()
    }
    
    //Function to return imgage with our URLString from our decoded JSON data
    func getSprite(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void){
        guard let imageURL = URL(string: urlString) else { completion(.failure(.noImage)); return}
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error{
                print("Error getting image: \(error)")
                completion(.failure(.noImage))
                return
            }
            
            guard let imageData = data else {
                completion(.failure(.noData))
                return
            }
            
            if let image = UIImage(data: imageData){
                completion(.success(image))
            } else {
                completion(.failure(.noImage))
            }
        }
        task.resume()
    }
    
    //MARK: - Save + Delete
    //Function to help us create and append a pokemon to our array of Pokemon objects
    func savePokemon(pokemon: Pokemon){
        let newPokemon = Pokemon(name: pokemon.name, id: pokemon.id, sprites: pokemon.sprites, ability: pokemon.ability, types: pokemon.types)
        myPokemon.append(newPokemon)
    }
    
    //Function to find the index of the pokemon we are deleting and remove it from the array
    func deletePokemon(pokemon: Pokemon){
        guard let index = myPokemon.firstIndex(of: pokemon) else { return }
        myPokemon.remove(at: index)
    }
}
