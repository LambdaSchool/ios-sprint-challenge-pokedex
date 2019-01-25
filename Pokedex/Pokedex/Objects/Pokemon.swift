//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cameron Dunn on 1/25/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import Foundation

struct Pokemon: Codable{
    var name: String
    var identifier: Int
    var types: [Type]
    var abilities: [Ability]
    
    enum CodingKeys: String, CodingKey{
        case name, types, abilities
        case identifier = "id"
    }
}
struct Ability: Codable, Equatable{
    var isHidden : Bool
    var slot : Int
    var ability: DataStruct
    
    enum CodingKeys: String, CodingKey{
        case isHidden = "is_hidden"
        case slot, ability
    }
}
struct Type: Codable, Equatable{
    var slot : Int
    var type: DataStruct
}
struct DataStruct: Codable, Equatable{
    var name : String
    var url : URL
}
struct PokemonResults: Codable{
    var pokemonResults : [Pokemon]
}
