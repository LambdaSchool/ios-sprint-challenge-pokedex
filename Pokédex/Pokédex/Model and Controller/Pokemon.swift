//
//  Pokemon.swift
//  Pokédex
//
//  Created by Samantha Gatt on 8/10/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

struct Pokemon: Equatable, Codable {
    var name: String
    var id: String
    var types: String
    var abilities: String
}

//struct PokemonNameAndID: Equatable, Codable {
//    var name: String
//    var id: String
//}
//
//struct PokemonTypesAndAbilities: Equatable, Codable {
//    var types: [String]
//    var abilities: [Int]
//}
//
//struct Types {
//    var name: String
//}
