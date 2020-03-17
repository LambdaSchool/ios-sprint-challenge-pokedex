//
//  PokemonImporter.swift
//  Pokedex
//
//  Created by Lotanna Igwe-Odunze on 11/2/18.
//  Copyright © 2018 Lotanna. All rights reserved.
//

import Foundation
import UIKit

var foundPokemon: Pokemon? //Global so I can reference it anywhere.

class PokemonImporter {
    
    var webPoke: Pokemon?
    
    
//Import Pokemon from Pokemon API

let pokemonAPI = URL(string: "https://pokeapi.co/api/v2/")!

func getPokemon(searchedPokemon: String, completion: @escaping (Error?) -> Void) {
    //First of all...
    guard var grabbedPoke = webPoke else { return }
    
    //Adds /pokemon/ to base URL
    var url = pokemonAPI.appendingPathComponent("pokemon")
    
    //Appends the name of the searched Pokemon to the base URL/pokemon/
    url.appendPathComponent(searchedPokemon.lowercased())
    
    print(url) //Making sure I'm accessing the right API.
    
    var request = URLRequest(url: url) //Making a request from the API URL then assigning the request to a property for easy manipulation later.
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in //Requesting both data and the error information in case I can't get the data.
        print("Error")
        if let error = error { //Assigns the standard error to a property so it can be customised.
            NSLog("Error: \(error.localizedDescription)") //Print the error description not just the standard error message
            completion(error) //Show error message in Debugger log.
            return
        }
        
        //Assigning the data that's fetched to a property for easy manipulation later.
        guard let foundData = data else {
        
        NSLog("Data was not recieved.") //Print this to the Debugger log if there's an error.
            
        completion(error) //Implement the error message if we fail to get data.
            
            return }
        
        do { //Same Do-Catch statement from normal Persistence but from Data above not local file
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedPokemon = try jsonDecoder.decode(Pokemon.self, from: foundData)
            grabbedPoke = decodedPokemon //Put decoded Pokemon info into a property
            
            //Assign the decoded info property to the global Pokemon
            foundPokemon = grabbedPoke
            
            completion(nil)//Set completion to nothing since decoding worked.
        }
        catch { //In case Decoding doesn't work.
            NSLog("Error: \(error.localizedDescription)")
            completion(error) //Show error message in Debugger log.
            return
                }
        }.resume() //Resumes the fetch function if it's been suspended e.g. because of errors.
    }//End of Get Pokemon Info function.
    
    
    //Get Pokemon Image
    func grabImage(searchedPokemon: Pokemon, completion: @escaping (Error?, Pokemon?) -> Void) {
        //First of all...
        guard var grabbedPoke = webPoke else { return }
        
        
        guard let requestURL = URL(string: ((grabbedPoke.sprites.first?.pokemonSprite.frontDefault)!)) else {
            NSLog("Couldn't get Pokemon image")
            completion(NSError(), nil)
            return
        }
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching image: \(error)")
                completion(error, nil)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned.")
                completion(NSError(), nil)
                return
            }
            
            grabbedPoke.image = data //Put the decoded image data into a property
            completion(nil, grabbedPoke)
            
            //Assign the decoded image property to the global Pokemon
            foundPokemon?.image = grabbedPoke.image
            
            return
            
            }.resume()
    }
    
}
