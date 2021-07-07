//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ivan Caldwell on 12/7/18.
//  Copyright © 2018 Ivan Caldwell. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    let image: UIImage
    let name: String
    let id: Int
    let type: String
    let ability: String 
}
