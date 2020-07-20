//
//  bearer.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation

struct Bearer: Codable {
    let token: String
    let id: Int
}
