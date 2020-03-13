//
//  Sprite.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

struct Sprite: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
