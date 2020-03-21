//
//  Pokemon.swift
//  Sprint-Pokemon
//
//  Created by Breena Greek on 3/20/20.
//  Copyright © 2020 Breena Greek. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    var name: String
    var id: Int
    var type: String
    var ability: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case type
        case ability
        case imageURL = "front_shiny_female"
    }
}

struct SearchResults: Codable {
    let results: [Pokemon]
}
