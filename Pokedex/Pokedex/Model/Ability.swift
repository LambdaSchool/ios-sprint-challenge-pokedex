//
//  Ability.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import Foundation

struct Ability: Codable{
    let name: String
    let url: String
    
    init(name: String, url: String) {
        // let types = types[0] ?? ""
        // let abilities = abilities[0] ?? ""
        (self.name, self.url) = (name, url)
    }
}
