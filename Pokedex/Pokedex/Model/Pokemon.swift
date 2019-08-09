//
//  Pokemon.swift
//  Pokedex
//
//  Created by Bradley Yin on 8/9/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let abilities: [Ability]
    let sprites: [String : URL]
    let types: [Type]
    var imageData: Data?
}
