//
//  PokeMon.swift
//  Networking Sprint Challenge - PokeDex
//
//  Created by Vijay Das on 2/1/19.
//  Copyright © 2019 Vijay Das. All rights reserved.
//


// file for the PokeMon model

import Foundation

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let abilities: [Ability]
    let type: [Type]
    let sprites: SpriteImages

 //   var imageData: Data?
    
    // need arrays for abilities, types ??
}

struct SpriteImages: Codable, Equatable {
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "frontDefault"
}
}

struct Ability: Codable,Equatable {
    let subAbility: subAbility

}

struct subAbility: Codable, Equatable {
    let name: String
    
}

struct Type: Codable, Equatable {
    let subType: String
}

struct subType: Codable, Equatable {
    let type: String
}





