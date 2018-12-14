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
    
    static let shared = SearchController()
    private init () {}
    
    //Set the base URL
    let baseURL = URL(string: "https://pokeapi.co/api/v2")
    
    //Prepare the search
    func performSearch(with searchTerm: String, completion: @escaping ((Error?) -> Void)) {
        
    }
    
    //func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
    
    //    func searchForPeople(with searchTerm: String, completion: @escaping ( (Error?) -> Void)) {
    
    
} //End of class
