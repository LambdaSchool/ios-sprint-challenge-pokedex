//
//  Pokemon.swift
//  Pokedex
//
//  Created by David Wright on 1/26/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: String
    let ability: String
    let types: [String]
}
