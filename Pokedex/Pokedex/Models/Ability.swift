//
//  Ability.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

struct Ability: Codable, Equatable {
    let ability: AbilityDetail
    
    struct AbilityDetail: Codable, Equatable {
        let name: String
    }
}
