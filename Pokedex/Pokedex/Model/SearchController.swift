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
    private(set) var searchResult: [SearchResult]
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    static let shared = SearchController()
    private init () {}
    
   
    
    let po
    
    //Hold the pokemon here
    private var searchResult: [SearchResult] = []
    
    //Prepare the search
    func performSearch(with searchTerm: String, completion: @escaping ((Error?) -> Void)) {
     //   let pokemonURL = baseURL?.appendingPathComponent(searchTerm, true)
        
        
        
//        var getThisPokemon = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//
       // var pokemonURL = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //Create the necessary API search URL
        
        guard let requestURL = pokemonURL?.url else {
            NSLog("Wasn't able to construct URL")
            completion(NSError())
            return
        }
        }
        
        
    }
    
    //func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
    
    //    func searchForPeople(with searchTerm: String, completion: @escaping ( (Error?) -> Void)) {
    
    
} //End of class
