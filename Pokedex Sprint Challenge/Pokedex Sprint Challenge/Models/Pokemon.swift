//
//  Pokemon.swift
//  Pokedex Sprint Challenge
//
//  Created by Mark Poggi on 4/10/20.
//  Copyright © 2020 Mark Poggi. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    
    var name: String?
    var imageURL: String?
    var id: String?
    var type: String?
    var ability: String?
    
    private enum PokemonCodingKeys: String, CodingKey {
    case name
    case imageURL
    case id
    case type
    case ability
    }
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonCodingKeys.self)
    }
}

struct PokemonSearchResults: Codable {
    let results: [Pokemon]
}
