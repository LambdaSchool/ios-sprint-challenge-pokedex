//
//  Pokemon.swift
//  Pokedex
//
//  Created by Hannah Bain on 5/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let types: [Type]
    let sprites: Sprite 
    
}

/*
 struct Pokemon: Decodable {
     let name: String
     let id: Int
     let sprites: Sprite
     let types: [Type]
     
 }
 struct Sprite: Decodable {
     let frontDefault: URL
     
 }
 struct Type: Decodable, Equatable {
     let type: Species
 }
 struct Species: Equatable, Codable {
     let name: String
 }
 
 need to comment explaining this setup. 
 
 */
