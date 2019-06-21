//
//  PokeModel.swift
//  Pokedex
//
//  Created by Jake Connerly on 6/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation
import UIKit


struct PokeMon: Codable {
    var name: String
    var sprites: Data
    var id: Int
    var types: String
    var abilities: String
}
