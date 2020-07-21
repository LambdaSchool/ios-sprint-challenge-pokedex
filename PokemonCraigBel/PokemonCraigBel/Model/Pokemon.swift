//
//  Pokemon.swift
//  PokemonCraigBel
//
//  Created by Craig Belinfante on 7/19/20.
//  Copyright © 2020 Craig Belinfante. All rights reserved.
//

import Foundation
import UIKit

class Pokemon: Codable {
      let name: String
      let id: Int
      let abilities: [String]
      let types: [String]
      let imageURL: String
}
    
