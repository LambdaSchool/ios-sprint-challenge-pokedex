//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vici Shaweddy on 9/13/19.
//  Copyright © 2019 Vici Shaweddy. All rights reserved.
//

import Foundation


struct Pokemon: Codable {
    let id: Int
    let image: String
    let name: String
    let types: [String]
    let abilities: [String]
}
