//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sameera Roussi on 5/10/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import Foundation

import UIKit

class Pokemon {
    var name: String?
    var id: String
    var abilities: String
    var types: String
    var sprite: UIImage
    var detail: Bool = false
    
    init(name: String, id: String, abilities: String, types: String, sprite: UIImage) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
        self.sprite = sprite
    }
}
