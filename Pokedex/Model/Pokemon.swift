//
//  Pokemon.swift
//  Pokedex
//
//  Created by macbook on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct PokemonSearch: Codable {
    let results: [Pokemon]
}

struct Pokemon: Equatable, Decodable, Encodable {
    var name: String
    var id: String
    var abilities: String
    var types: String
    var imageURL: String = "sprites"  // TODO: might have to set this with a didSet so it takes in a number inside the string to determine wich picture of this pokemon
    
    
//    enum CodingKeys: String, CodingKey {
//
//        case name = "name"
//        case id = "id"
//        case abilities = "abilities"
//        case types = "types"
//    }
}
