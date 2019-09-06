//
//  Pokemon.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let abilities: [String]
   
    
    
}

struct Types: Codable {
    
    let name: String
    
}

struct Abilities: Codable {

    let name: String
}
