//
//  Pokemon.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

struct Pokemon : Codable {
    let id: Int
    let name: String
    let image: Sprites?
    let types: [Type]
    let abilities: [Ability]
    
    enum CodingKeys: String,CodingKey {
        case id
        case name
        case image = "sprites"
        case types = "types"
        case abilities
    }
    
}

struct Type: Codable {
  
    let type : [String:String]
    
}

struct Ability : Codable {
    let ability : [String:String]
}


struct Sprites : Codable {
    let image : String?
    
    enum CodingKeys: String,CodingKey {
        case image = "front_default"
    }
}








