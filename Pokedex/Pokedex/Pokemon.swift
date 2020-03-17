//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lotanna Igwe-Odunze on 11/2/18.
//  Copyright © 2018 Lotanna. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    
    var name: String //From API
    let types: [TypesLevelOne] //From API
    let abilities: [AbilitiesLevelOne] //From API
    var id: Int //From API
    let sprites: [SpritesLevelOne] //From API
    var image: Data? //Not from API
    
    enum CodingKeys: String, CodingKey {
        case name
        case types
        case abilities
        case id
        case sprites
    }
    
    //Structs for the API information
    
    struct TypesLevelOne: Codable, Equatable {
        let pokemonType: TypesLevelTwo
        
        struct TypesLevelTwo: Codable, Equatable {
            let name: String
        }
    }
   
    struct AbilitiesLevelOne: Codable, Equatable {
        let ability: AbilitiesLevelTwo
        
        struct AbilitiesLevelTwo: Codable, Equatable {
            let name: String
            
        }
    }
    
    struct SpritesLevelOne: Codable, Equatable {
        let pokemonSprite: SpritesLevelTwo
        
        struct SpritesLevelTwo: Codable, Equatable {
            let frontDefault: String
            
        }
    }
    
    //Conforming to Equatable
   static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    } 
}
