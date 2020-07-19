//
//  Pokemon.swift
//  Pokemon
//
//  Created by Nick Nguyen on 2/14/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation

struct Pokemon : Equatable,Comparable, Codable, Hashable {
  static func < (lhs: Pokemon, rhs: Pokemon) -> Bool {
    return lhs.id < rhs.id
  }
  
  static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
    return lhs.id == rhs.id
  }
  
  let id: Int
  var name: String
  let image: Sprites?
  let types: [Type]
  let abilities: [Ability]
  
  enum CodingKeys: String,CodingKey {
    case id
    case name
    case image = "sprites"
    case types = "types"
    case abilities
  }
}

struct Type: Codable, Hashable {
  let type : [String:String]
}
struct Ability : Codable, Hashable {
  let ability : [String:String]
}

struct Sprites : Codable, Hashable {
  let image : String?
  
  enum CodingKeys: String,CodingKey {
    case image = "front_default"
  }
}

struct PokemonNames: Codable {
  let results: [PokemonName]
  
  enum CodingKeys: String, CodingKey {
    case results = "results"
  }
}

struct PokemonName: Codable {
  let name: String
  enum CodingKeys: String,CodingKey {
    case name = "name"
  }
}
