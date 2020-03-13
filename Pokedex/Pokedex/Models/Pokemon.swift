//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_259 on 3/13/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [Type]
    let sprites: Sprite
}
