//
//  Pokemon.swift
//  pokedex
//
//  Created by Sammy Alvarado on 5/17/20.
//  Copyright © 2020 Sammy Alvarado. All rights reserved.
//

import Foundation


struct Pokemon: Decodable {
    // Top Levels
    let id: Int
    let name: String
    // They have sublevels
    let sprites: Sprite
    let types: String
    let abilites: String
}

struct Sprite: Decodable {
    let frontDefault: URL
}

struct Ability: Equatable, Codable {
    let ability: Species
}

struct Type: Decodable, Equatable {
    let type: Species
}

struct Species: Equatable, Codable {
    let name: String
}
    
/*
 // Austins Example
 
 struct Pokemonw: Decodable {
     let name: String
     let id: Int
     let sprites: Sprite
     let types: [Type]
 }


 struct Sprite: Decodable {
     let frontDefault: URL
 }

 struct Ability: Equatable, Codable {
     let ability: Species
 }

 struct Type: Decodable, Equatable {
     let type: Species
 }
 struct Species: Equatable, Codable {
     let name: String
 }
 */
 

  // This is my top levels
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case types
//        case abilites
//
//        enum TypeDescriptionKeys: String, CodingKey {
//            case type
//
//            enum Typeskeys: String, CodingKey {
//                case name
//            }
//        }
//
//        enum AbilityDescriptionsKeys: String, CodingKey {
//            case ability
//
//            enum AbilityKeys: String, CodingKey {
//                case name
//            }
//        }
//    }
//
//}
//
//struct SearchResult: Codable {
//    let results: [SearchResult]
//}



/*
 
 id:12
 name:"butterfree"
 
 ▶
 abilities:[] 1 item
     ▶
     0:{} 3 keys
     is_hidden:true
     slot:3
     ▶
     ability:{} 2 keys
     name:"tinted-lens"
     url:"https://pokeapi.co/api/v2/ability/110/"

 ▶
 types:[] 1 item
     ▶
     0:{} 2 keys
     slot:2
     ▶
     type:{} 2 keys
     name:"flying"
     url:"https://pokeapi.co/api/v2/type/3/"
 
 */
