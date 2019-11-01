//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jon Bash on 2019-11-01.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import Foundation

class Pokemon: Codable {
    let name: String
    let id: Int
    let types: [String]
    let abilities: [String]
    let imageURL: URL
    let imageData: Data?
    
    init(name: String, id: Int, types: [String], abilities: [String], imageURL: URL) {
        self.name = name
        self.id = id
        self.types = types
        self.abilities = abilities
        self.imageURL = imageURL
        self.imageData = nil
    }
}

struct APIPokemon: Codable {
    let name: String
    let id: Int
    let types: [SpeciesType]
    let abilities: [Ability]
    let sprites: [String : String]
    
    struct Ability: Codable {
        let ability: SubAbility
        
        struct SubAbility: Codable {
            let name: String
        }
    }
    
    struct SpeciesType: Codable {
        let type: SubType
        
        struct SubType: Codable {
            let name: String
        }
    }
}

struct mainStruct: Equatable, Decodable {
    
    let someVar: String
    let otherVar: Int
    
    let items: [Item]
    
    struct Item: Equatable, Decodable {
        
        let item: SubItem
        
        struct SubItem: Equatable, Decodable {
            
            let descriptor: String
        }
    }
}
