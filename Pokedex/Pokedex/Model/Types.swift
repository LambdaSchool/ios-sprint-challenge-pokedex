//
//  Types.swift
//  Pokedex
//
//  Created by Benjamin Hakes on 12/7/18.
//  Copyright © 2018 Benjamin Hakes. All rights reserved.
//

import Foundation
// individual entry
struct Types: Codable{
    let name: String
    let url: String
    let types: [Type]
    
}
