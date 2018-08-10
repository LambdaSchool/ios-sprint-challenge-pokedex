//
//  Pokemon.swift
//  Pokedex
//
//  Created by Andrew Liao on 8/10/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

class Pokemon: Codable, Equatable {
    let name: String
    let id: String
    let abilities: String
    let types: String

    
    init(name: String, id: String, abilities: String, types: String) {
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //Decode name and id and set as respective Pokemon properties
        let name = try container.decode(String.self, forKey: .name)
        let id = String( try container.decode(Int.self, forKey: .id))
        
        

//        let abilities = try container.decode([String:AnyClass].self, forKey: .abilities)
        
        
        
        
//        let types = try container.decode(String.self, forKey: .types)
            let abilities = "Placeholder"
            let types = "Placeholder"
        // 4
        self.name = name
        self.id = id
        self.abilities = abilities
        self.types = types
    }
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name &&
            lhs.id == rhs.id &&
            lhs.abilities == rhs.abilities &&
            lhs.types == rhs.types
        
    }
    

}

