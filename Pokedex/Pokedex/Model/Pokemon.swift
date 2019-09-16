//
//  Pokemon.swift
//  Pokedex
//
//  Created by Fabiola S on 9/13/19.
//  Copyright © 2019 Fabiola Saga. All rights reserved.
//

import Foundation
import UIKit

class Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Abilities]
    let types: [Types]
    let weight: Int
    let sprites: Sprites
    var imageData: Data?
    
    
}

struct SearchResults: Codable {
    let results: [Pokemon]
}

struct Ability: Codable {
    let abilityName: String
}

struct Abilities: Codable {
    let ability: Ability
}

struct Type: Codable {
    let typeName: String
}

struct Types: Codable {
    let type: Type
}

struct Sprites: Codable {
    let sprite: String
}
