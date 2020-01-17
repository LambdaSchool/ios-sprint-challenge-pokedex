//
//  Pokemon.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 1/17/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String?
    let id: Int?
    let abilities: [Ability]
    // sprites: -> front_default ???
    let types: [Type]
}

struct Type: Decodable {
    let type: TypeName
}

struct TypeName: Decodable {
    let name: String
}

struct Ability: Decodable {
    let ability: AbilityName
}

struct AbilityName: Decodable {
    let name: String
}

/*
 "types": [
   {
     "slot": 2,
     "type": { "name": "flying", "url": "https://pokeapi.co/api/v2/type/3/"}
   }
 ]
 
{ slot: int , type: {name: string, url: url} }
 
 "abilities": [
   {
     "is_hidden": true,
     "slot": 3,
     "ability": {
       "name": "tinted-lens",
       "url": "https://pokeapi.co/api/v2/ability/110/"
     }
   }
 ]
 
 */
