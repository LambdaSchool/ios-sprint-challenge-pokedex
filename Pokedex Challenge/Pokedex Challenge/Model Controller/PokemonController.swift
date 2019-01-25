//
//  PokemonController.swift
//  Pokedex Challenge
//
//  Created by Michael Flowers on 1/25/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")! //using the "!" because if this doesn't work then I want the app to crash so I can handle the error
    
    var pokemons: [Pokemon] = []
    
    //we have the data source on line 15 so we don't have to put it in the fetch function, we will append the array in the url session.
    func fetchPokemon(with searchTerm: String, completion: @escaping (Error?) -> Void) {
        //construct the url
        let url = baseURL.appendingPathComponent(searchTerm)
        
        //the httpMethod is a get by default so we don't have to explicitly declare we can just call the urlsession
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            //check for error
            if let error = error {
                NSLog("Error fetching data from server: \(error.localizedDescription)")
                completion(error)
                return
            }
            //unwrap the data. decode the data. assign data to model object data source of truth
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do{
                let jd = JSONDecoder()
                let returnedPokemon = try jd.decode(Pokemon.self, from: data)
                
                //since we are searching for one pokemon we can append it to the array
                self.pokemons.append(returnedPokemon)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(error)
                return
            }
        }.resume()
    }
    
    func fetchImage(of pokemon: Pokemon, completion: @escaping (Error?) -> Void ){
        //new url for image.
        let imageURL = URL(string: pokemon.sprites.imageURL)! //if it doesn't work then the app will crash but I'll know whats wrong
        
        //its another get so I don't have to construct the urlRequest because it defaults to it. So I can just start the urlsession
        
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            //like always, check for the error
            if let error = error {
                NSLog("Error fetching ImageData from server: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            //unwrap data. Decode data. turn data into an uiimage.....
            guard let data = data else {
                completion(NSError())
                return
            }
            
            do{
                let jd = JSONDecoder()
               let returnedImage = try jd.decode(Pokemon.self, from: data)
                let image = UIImage(data: data) //do i create an image array?
            
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(error)
                return
            }
        }
    }
}
