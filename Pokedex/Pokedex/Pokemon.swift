//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_268 on 2/14/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation


enum types {
    
    case normal
    case poison
    case flying
    case psychic
    case grass
    case ground
    case ice
    case fire
    case rock
    case dragon
    case water
    case bug
    case dark
    case fighting
    case ghost
    case steel
    case electric
    case fairy
    
}

struct Pokemon {
    var name: String
    var id: Int
    var abilities: [(String, String)]
    var type: [types]
}
