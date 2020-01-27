//
//  Pokemon.swift
//  PodedexB
//
//  Created by Gerardo Hernandez on 1/26/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    let sprites: Sprite
    let form_name: [Forms]
    
}


struct Abilities: Codable, Equatable {
    let ability: Ability
}

struct Ability: Codable, Equatable {
    let name: String
}

struct Types: Codable, Equatable {
    let type: TypeName
}


struct TypeName: Codable, Equatable {
    let name: String
}

struct Forms: Codable, Equatable {
    let name: String
    let form: FormName
}

struct FormName: Codable, Equatable {
    let form_name: String
}
struct Sprite: Codable, Equatable {
    let front_shiny: String
}


