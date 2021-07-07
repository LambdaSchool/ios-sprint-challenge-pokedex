//
//  Pokemon.swift
//  Pokedex Sprint
//
//  Created by Alex Shillingford on 6/21/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name, type, abilities, front_default: String
    let id: Int
}

