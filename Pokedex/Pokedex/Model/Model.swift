//
//  Model.swift
//  Pokedex
//
//  Created by Cameron Dunn on 1/25/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import Foundation

class Model{
    var savedPokemon : [Pokemon] = []
    
    
    func pokemonSearch(term searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void){
        var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        baseURL.appendPathComponent("\(searchTerm.lowercased())/")
        print(baseURL)
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error{
                print("There was an error while initializing the data task: \(error)")
                completion(nil, NSError())
                return
            }
            guard let data = data else{
                print("There was an error while retrieving the data from the API. No error was returned.")
                completion(nil, NSError())
                return
            }
            do{
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(Pokemon.self, from: data)
                let pokemonResults = results
                self.fetchImages(for: pokemonResults, completion: completion)
            }catch{
                print("Unable to complete decoding \(error)")
                completion(nil, NSError())
                return
            }
        }.resume()
    }
    func fetchImages(for pokemon: Pokemon, completion: @escaping (Pokemon?, Error?) -> Void){
        var imageLinks : [String] = []
        var i = 0
        if(pokemon.imageLink.backDefault != nil){
            imageLinks.append(pokemon.imageLink.backDefault!)
        }
        if(pokemon.imageLink.backShinyFemale != nil){
            imageLinks.append(pokemon.imageLink.backShinyFemale!)
        }
        if(pokemon.imageLink.backShiny != nil){
            imageLinks.append(pokemon.imageLink.backShiny!)
        }
        if(pokemon.imageLink.backFemale != nil){
            imageLinks.append(pokemon.imageLink.backFemale!)
        }
        if(pokemon.imageLink.frontDefault != nil){
            imageLinks.append(pokemon.imageLink.frontDefault!)
        }
        if(pokemon.imageLink.frontShinyFemale != nil){
            imageLinks.append(pokemon.imageLink.frontShinyFemale!)
        }
        if(pokemon.imageLink.frontShiny != nil){
            imageLinks.append(pokemon.imageLink.frontShiny!)
        }
        if(pokemon.imageLink.frontFemale != nil){
            imageLinks.append(pokemon.imageLink.frontFemale!)
        }
        var pokemonwithimagedata = pokemon
        while i < imageLinks.count{
            URLSession.shared.dataTask(with: URL(string: imageLinks[i])!){ (data,_,error) in
                if let error = error{
                    print("An error occured while downloading the images: \(error)")
                    return
                }
                guard let data = data else {
                    print("An error occured while downloading the images. No error was found.")
                    return
                }
                pokemonwithimagedata.imageData.append(data)
            }.resume()
            i += 1
        }
        completion(pokemonwithimagedata, nil)
    }
}
