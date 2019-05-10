//
//  PokemonController.swift
//  Pokemon
//
//  Created by Michael Flowers on 5/10/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var pokemons = [Pokemon]()
    
    //when the user swipes to delete, this is th function that will get called to remove said pokemon from the data source of truth
    func delete(pokemon: Pokemon){
        guard let pokeToDelete = pokemons.firstIndex(of: pokemon) else { return }
        pokemons.remove(at: pokeToDelete)
    }
    
    //when the save button is hit on the detail view controller,this is the function that will get called to append the pokemon to show up in the tableView cells
    func save(pokemon: Pokemon){
        pokemons.append(pokemon)
    }
    
    //create a fetch Pokemon function
    func fetchPokemon(with name: String, completion: @escaping (Pokemon?, Error?) -> Void){
        //construct the url for fetching
        let url = baseURL.appendingPathComponent(name.lowercased())
        
        //now that I have the url I can make a request
        let request = URLRequest(url: url)
        
        //because the default httpMethod is GET I don't have to construct it also I'm not sending data so I don't have to write it to the body
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error making network call for fetcing pokemon: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error unwrapping data in the network call for fetching a pokemon: \(NSError())")
                completion(nil, NSError())
                return
            }
            
            let jsonD = JSONDecoder()
            do {
                let pokemon = try jsonD.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                print("Error decoding the data in the do catch block for fetching a pokemon: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    //remember we have to get the pokemon first, because it has the property of the url we need to get the image
    func fetchSprite(with pokemon: Pokemon, completion: @escaping (UIImage?, Error?) -> Void){
        //construct the url to get the image
        let url = URL(string: pokemon.sprities.imageURL)!
        
        //now that we have the url we can create the reqeust
        let request = URLRequest(url: url)
        
        //since we are getting, thats the default and since we are not sending data we dont have to write to the body
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error making network call for fetcing spirte image: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error unwrapping data in the network call for sprite: \(NSError())")
                completion(nil, NSError())
                return
            }
            
            //we should have the data at ths point. use it to create the image/remember we don't have to decode it because its not in json. just use the data to construct an image
            let image = UIImage(data: data)
            completion(image, nil)
        }.resume()
    }
}
