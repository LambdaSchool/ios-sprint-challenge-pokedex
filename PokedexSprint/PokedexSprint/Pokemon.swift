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
    let sprites: Sprite
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

struct Sprite: Decodable {
    let front_default: URL // ?
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
 
 "sprites": {
   "back_female": "http://pokeapi.co/media/sprites/pokemon/back/female/12.png",
   "back_shiny_female": "http://pokeapi.co/media/sprites/pokemon/back/shiny/female/12.png",
   "back_default": "http://pokeapi.co/media/sprites/pokemon/back/12.png",
   "front_female": "http://pokeapi.co/media/sprites/pokemon/female/12.png",
   "front_shiny_female": "http://pokeapi.co/media/sprites/pokemon/shiny/female/12.png",
   "back_shiny": "http://pokeapi.co/media/sprites/pokemon/back/shiny/12.png",
   "front_default": "http://pokeapi.co/media/sprites/pokemon/12.png",
   "front_shiny": "http://pokeapi.co/media/sprites/pokemon/shiny/12.png"
 }
 
 */
