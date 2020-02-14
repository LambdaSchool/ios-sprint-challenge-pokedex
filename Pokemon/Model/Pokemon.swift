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
    let abilities: [Abilitiy]
    let image: [Sprites]
    
    enum CodingKeys: String,CodingKey {
        case id
        case name 
        case abilities = "abilities"
        case image = "sprites"
    }
    
}
struct Abilitiy:  Codable {
    let name: String
    
}

struct Sprites : Codable {
    let image : String?
    
    enum CodingKeys: String,CodingKey {
        case image = "front_default"
    }
}



