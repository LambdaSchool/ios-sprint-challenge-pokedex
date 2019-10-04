//
//  Ability.swift
//  Pokedex
//
//  Created by Isaac Lyons on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Ability: Codable {
    let is_hidden: Bool
    let ability: NamedAPIResource
}
