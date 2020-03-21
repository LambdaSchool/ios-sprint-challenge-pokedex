//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jarren Campos on 3/20/20.
//  Copyright © 2020 Jarren Campos. All rights reserved.
//

import Foundation


import UIKit

struct Pokemon: Codable {
    let id: Int
    let name: String
//    let abilities: [Ability]
//    let types: [Type]
//    let sprites: Sprite
    var results: [Pokemon]
}

