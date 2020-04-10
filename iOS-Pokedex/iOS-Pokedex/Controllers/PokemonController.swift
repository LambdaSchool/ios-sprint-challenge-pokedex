//
//  PokemonController.swift
//  iOS-Pokedex
//
//  Created by Cameron Collins on 4/10/20.
//  Copyright © 2020 Cameron Collins. All rights reserved.
//

import UIKit

protocol PokemonControllerDelegate {
    //Nothing yet
}

class PokemonController {
    
    //Variables
    var url = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    var pokemon: PokemonTesting?
    var pokemonAdded: [PokemonTesting] = []
    var currentImage: UIImage?
    
    //Functions
    func getPokemon(name: String, completion: @escaping ()-> Void) {
        
        let newURL = url?.appendingPathComponent(name)
        
        guard let myURL = newURL else {
            completion()
            return
        }
        
        //Fetch Json information
        URLSession.shared.dataTask(with: myURL) { (data, response, error) in
            
            //Error Checking
            if let error = error {
                print("Error fetching JSON in getJSON: \(error.localizedDescription)")
                completion()
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error Bad Reponse Code")
                completion()
                return
            }
            
            //Parse JSON
            guard let data = data else {
                print("Error Bad Data")
                completion()
                return
            }
            
            self.parseJSON(data: data)
            completion()
        }.resume()
    }
        
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(PokemonTesting.self, from: data)
            self.pokemon = decoded
            print(decoded)
        } catch {
            print("Error Decoding JSON: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: - Image Conversion
    func convertImage(url: URL?, completion: @escaping () -> Void) {
        guard let url = url else {
            print("Bad Image URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //Error Checking
            if let error = error {
                print("Error fetching JSON in getJSON: \(error.localizedDescription)")
                completion()
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error Bad Reponse Code")
                completion()
                return
            }
            
            //Parse JSON
            guard let data = data else {
                print("Error Bad Data")
                completion()
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error Bad Image")
                return
            }
            
            self.currentImage = image
            completion()
        }.resume()
        
    }
}
