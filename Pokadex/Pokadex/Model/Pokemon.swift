//
//  Pokemon.swift
//  Pokadex
//
//  Created by brian vilchez on 9/6/19.
//  Copyright © 2019 brian vilchez. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
	let name: String
	let id:Int
	let sprites: Sprite
	//let abilites: PokemonAbility
}

struct PokemonAbility: Decodable {
	
}

struct Sprite: Decodable {
	let frontDefault: URL
}
