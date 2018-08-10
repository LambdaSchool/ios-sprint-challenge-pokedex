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
    
    // commented out so the app will still build
    // conceptual...
    // var types: String { return String([Pokemon.TypeArray.TheType.name]) }
    // So json decoder will know where to store what I want...
    // var types: Pokemon.TypeArray.TheType
    // then in the decode func I can say [Pokemon.TypeArray.TheType].self
    // It'll return an array of TheType and each will have a .name attribute/property
    var abilities: String
    
    struct TypeArray: Equatable, Codable {
        var type: Pokemon.TypeArray.TheType
            
        // Can't name it plain Type
        struct TheType: Equatable, Codable {
            var name: String
        }
    }
    
    // Fix below
//    struct AbilitiesDict: Equatable, Codable {
//        var abilitiesArray: [Pokemon.AbilitiesDict.AbilitiesArray]
//
//        struct AbilitiesArray: Equatable, Codable {
//            var ability: String
//        }
//    }
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



// types is an array

// ????
// ((pokemon) -> name: what I want, id: what I want, (types -> ints) -> slot: int, (type -> url: string, name: what I want (but there's going to be multiple...)
// types is same for abilities
