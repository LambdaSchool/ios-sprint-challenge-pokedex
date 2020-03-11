//
//  Abilities.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct AbilityElement: Codable {
    let ability: AbilityClass
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct AbilityClass: Codable {
    let name: String
    let url: String
}
