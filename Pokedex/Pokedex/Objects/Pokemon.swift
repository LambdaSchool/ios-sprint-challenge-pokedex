//
//  Pokemon.swift
//  Pokedex
//
//  Created by Cameron Dunn on 1/25/19.
//  Copyright © 2019 Cameron Dunn. All rights reserved.
//

import Foundation
import UIKit
struct Pokemon: Codable{
    var name: String
    var identifier: Int
    var types: [Type]
    var abilities: [Ability]
    var imageLink: Sprites
    var imageData: [Data] = []
    
    enum CodingKeys: String, CodingKey{
        case name, types, abilities
        case identifier = "id"
        case imageLink = "sprites"
    }
}
struct Sprites: Codable{
    var frontDefault : String?
    var frontShiny : String?
    var frontFemale : String?
    var frontShinyFemale : String?
    var backDefault : String?
    var backShiny : String?
    var backFemale : String?
    var backShinyFemale : String?
    
    enum CodingKeys: String, CodingKey{
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
        case frontFemale = "front_female"
        case frontShinyFemale = "front_shiny_female"
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case backFemale = "back_female"
        case backShinyFemale = "back_shiny_female"
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
