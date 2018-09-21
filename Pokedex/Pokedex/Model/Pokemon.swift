//
//  Pokemon.swift
//  Pokedex
//
//  Created by Welinkton on 9/21/18.
//  Copyright © 2018 Jerrick Warren. All rights reserved.
//

import Foundation

struct  Pokemon: Equatable, Codable {
    
    var name: String
    var id: Int
    var abilities: [Abilities]
    var types : [Types]
    
    
    struct Abilities: Equatable, Codable {
        let ability: MoreDetail
    }
    
    struct MoreDetail: Equatable, Codable {
        let name: String
    }
    
    struct Types: Equatable, Codable {
        let type:  Name
    }

    struct Name: Equatable, Codable {
        let name: String
    }
    
    
// Double check this. 
}

