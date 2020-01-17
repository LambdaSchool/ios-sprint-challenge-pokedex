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
    // abilities: [String] ???
    // sprites: -> front_default ???
    let types: [Type]
}

struct Type: Decodable {
    let type: TypeName
}

struct TypeName: Decodable {
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
 */
