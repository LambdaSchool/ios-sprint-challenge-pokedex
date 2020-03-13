//
//  Pokemon.swift
//  Pokemon
//
//  Created by Michael Flowers on 5/10/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation


//VERY IMPORTANT -- IF ANY OF THE FOLLOWING WORDS ARE MISSPELLED OR WE'RE PARSING -DRILLING- DOWN THE JSON WRONG, THE ERROR WE WILL RECIEVE IS: "THE DATA COULDN'T BE READ BC IT'S MISSING"!!!!
struct Pokemon: Codable, Equatable {
    let id: Int
    let name: String
    let abilities: [AbilityArray]
    let sprites: Sprite
    let types: [TypeArray]
    
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name // && lhs.id == rhs.id
    }
}

//VERY IMPORTANT - The struct's property has to match the json, not it's type, For instance ths will work with xyz at the end. xyz's struct, though, would have to have a property in it that matches what is on the json.

struct AbilityArray: Codable {
    let ability: Abilityxyz
}

struct Abilityxyz: Codable {
    let name: String
}

struct Sprite: Codable {
    let imageURL: String  //will have to use the special jsond decoding, snakeCase
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "front_default"
    }
}

struct TypeArray: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
