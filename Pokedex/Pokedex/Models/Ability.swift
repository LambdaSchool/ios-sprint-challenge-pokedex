//
//  Ability.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

struct Ability: Codable {
    let ability: AbilityDetail
    
    struct AbilityDetail: Codable {
        let name: String
    }
}
