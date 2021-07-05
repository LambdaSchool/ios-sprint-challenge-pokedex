//
//  Pokemon.swift
//  ios-sprint-3
//
//  Created by Lambda-School-Loaner-11 on 8/10/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
    
    var name: String
    var id: String
    var abilities: String
    var type: String
}

struct Pokemons: Codable {
    let results: [Pokemon]
}

