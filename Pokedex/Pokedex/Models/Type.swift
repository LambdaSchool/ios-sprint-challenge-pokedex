//
//  Type.swift
//  Pokedex
//
//  Created by scott harris on 2/14/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

struct Type: Codable {
    let name: String
}

struct Types: Codable {
    let type: Type
}
