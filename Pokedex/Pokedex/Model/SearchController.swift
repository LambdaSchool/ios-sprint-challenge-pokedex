//
//  SearchController.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/14/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

class SearchController {
    // MARK: Data source
    static let shared = SearchController()
    private init() {}
    
    // The URL to the
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    //Hold the pokemon here
    private var searchResult: [SearchResult] = []
    
    //Prepare the search
    func performSearch(with searchTerm: String, completion: @escaping ((Error?) -> Void)) {
        let getThisPokemon = baseURL.appendingPathComponent(searchTerm, isDirectory: true)
        let pokemonURL = URLComponents(url: getThisPokemon, resolvingAgainstBaseURL: true)

        guard let requestURL = pokemonURL?.url else {
            NSLog("Wasn't able to construct URL")
            completion(NSError())
            return
        }
        
        //Create a URLSession to perform the dataTask
        URLSession.shared.dataTask(with: requestURL) { (data, _, error ) in
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                completion(error)
                return
            }
            
            // Check for data returned by the dataTask
            guard let data = data else {
                NSLog("Request did not return valid data")
                completion(error)
                return
            }
            
            // We have data, decode it and store it
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // Try and decode and store the data
            do {
                let searchResults = try jsonDecoder.decode(PokemonResult.self, from: data)
                self.searchResult = searchResults.results
                completion(nil)
            } catch {
                NSLog("Error decoding JSON: \(error)")
                completion(error)
                return
            }
            
        } .resume() // End of URLSession
        
        
    } // End of performSearch

    
    
} //End of class




//Make a dataTask to get the data

// let searchQueryItem = URLQueryItem(name: L = getThisPokemon.append
//   let pokemonURL = baseURL?.appendingPathComponent(searchTerm, true)
// let getThisPokemon = baseURL?.appendingPathComponent(searchTerm, isDirectory: true)
//var pokemonURL = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)


//func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {

//    func searchForPeople(with searchTerm: String, completion: @escaping ( (Error?) -> Void)) {


//        var getThisPokemon = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//
// var pokemonURL = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)

//Create the necessary API search URL

//        guard let requestURL = pokemonURL?.url else {
//            NSLog("Wasn't able to construct URL")
//            completion(NSError())
//            return
//            }
//        }
