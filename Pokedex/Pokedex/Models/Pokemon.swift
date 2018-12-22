//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sameera Leola on 12/21/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import UIKit

class Pokemon {
    var name: String?
    var id: String
    var abilities: String
    var types: String
    var sprite: UIImage
    
    init(name: String, id: String, abilities: String, types: String, sprite: UIImage) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprite = sprite
    }
}
