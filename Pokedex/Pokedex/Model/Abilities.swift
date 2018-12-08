//
//  Abilities.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import Foundation

struct Abilities: Codable{
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
    
    init(ability: Ability, is_hidden: Bool, slot: Int) {
        // let types = types[0] ?? ""
        // let abilities = abilities[0] ?? ""
        (self.ability, self.is_hidden, self.slot) = (ability, is_hidden, slot)
    }
    
}
