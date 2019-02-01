//
//  PokemonController.swift
//  w3r Pokedex Challenge
//
//  Created by Michael Flowers on 2/1/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    var pokemons = [Pokemon]()
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func savePokemon(with pokemon: Pokemon){
        pokemons.append(pokemon)
    }
    
    func delete(pokemon: Pokemon){
        //find index of pokemon in the array
        guard let index = pokemons.index(of: pokemon) else { return }
        pokemons.remove(at: index)
    }
    
    func fetchPokemon(with name: String, completion: @escaping (Pokemon?, Error?) -> Void){
        
        //pathcomponent url with name per api requirements
        let url = baseURL.appendingPathComponent(name.lowercased())
        
        //since the default of the httpMethod is GET we don't need to construct the request url, we can just start the data task
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching data from server: \(error.localizedDescription)")
                completion(nil,error)
                return
            }
            
            //decode the data we got back
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let jD = JSONDecoder()
                let pokemon = try jD.decode(Pokemon.self, from: data)
                completion(pokemon, nil)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil,error)
                return
            }
        }.resume()
    }
    
    //we also have to call the fetch function for the imageURL, but it is attached to the pokemon so we have to pass in a pokemon in order to get the url
    //we want an UIIMage back so we have to put it in the completion handler
    func fetchSprites(with pokemon: Pokemon, completion: @escaping (UIImage?, Error?) ->Void){
        //get the url from the pokemon...dont need to append the base url because the sprites are another, indenpendent url
        let url = URL(string: pokemon.sprites.urlImage)!
        
        //again we are just getting something from the api so we can just start the data task
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error with the sprites url: \(error.localizedDescription)")
                completion(nil,error)
                return
            }
            
            //decode the data we got back
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            let pokeImage = UIImage(data: data)
            completion(pokeImage, nil)
            //return
        }
    }
}
