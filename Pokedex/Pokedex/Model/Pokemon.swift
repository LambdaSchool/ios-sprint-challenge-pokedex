//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jeremy Taylor on 8/10/18.
//  Copyright © 2018 Bytes-Random L.L.C. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
}

struct ReceivedData: Codable {
    let name: String
    let id: Int
    let game_indices: [String]
}



