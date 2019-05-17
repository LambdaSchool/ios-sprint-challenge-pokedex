//
//  Pokemon.swift
//  Sprint3
//
//  Created by Kobe McKee on 5/17/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
    
    var id: Int
    var name: String
    var abilities: [Abilities]
    var types: [PokeTypes]
    var sprite: Sprite
   
}


struct Abilities: Codable {
    let ability: String
}

struct PokeTypes: Codable {
    let type: String
}

struct Sprite: Codable {
    var frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
