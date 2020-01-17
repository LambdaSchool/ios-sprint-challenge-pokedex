//
//  Pokemon.swift
//  PokeDex
//
//  Created by Aaron Cleveland on 1/17/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    let name: String
    let types: String
    let abilities: String
    let id: Int
    let images: UIImage
}
