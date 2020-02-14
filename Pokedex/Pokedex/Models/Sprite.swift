//
//  Sprite.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Sprite: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
}
