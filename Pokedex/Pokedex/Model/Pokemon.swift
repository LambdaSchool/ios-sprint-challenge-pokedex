//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ilgar Ilyasov on 9/21/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities: [Abilities]
    let types: [Types]
    
    
    struct Abilities: Codable, Equatable {
        let name: String
    }
    
    struct Types: Codable, Equatable {
        let name: String
    }
    
//    init(name: String, id: Int, abilities: [Abilities], types: [Types]) {
//        self.name = name
//        
//    }
}
