//
//  Abilities.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import Foundation

// individual entry
struct Abilities: Codable{
    let ability: [Ability]
    let is_hidden: Bool
    let slot: Int
    
}
