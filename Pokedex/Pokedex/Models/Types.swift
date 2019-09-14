//
//  Types.swift
//  Pokedex
//
//  Created by Joel Groomer on 9/14/19.
//  Copyright © 2019 Julltron. All rights reserved.
//

import Foundation

struct Type: Codable {
    let name: String
    let url: String
}

struct TypeContainer: Codable {
    let slot: Int
    let type: Type
}

struct Types: Codable {
    let typesInContainers: [TypeContainer]
}
