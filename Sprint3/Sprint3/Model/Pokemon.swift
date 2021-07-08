//
//  Pokemon.swift
//  Sprint3
//
//  Created by Victor  on 5/10/19.
//  Copyright © 2019 com.Victor. All rights reserved.
//

import Foundation

//model object
struct Pokemon: Codable, Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    var name: String
    var id: Int
    var abilities: [Abilities]
    var types : [Types]
    var sprites : Sprites
    
    struct Abilities: Equatable, Codable {
        let ability: Ability
    }
    
    struct Ability: Equatable, Codable {
        let name: String
    }
    
    struct Types: Equatable, Codable {
        let type:  Name
    }
    
    struct Name: Equatable, Codable {
        let name: String
    }
    
    struct Sprites: Codable {
        let frontDefault: String
    }
}
