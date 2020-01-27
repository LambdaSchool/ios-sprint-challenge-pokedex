//
//  Pokemon.swift
//  PodedexB
//
//  Created by Gerardo Hernandez on 1/26/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable, Equatable {
    let name: Name
    let id: Int
    let abilities: [Ability]
    let type: [TypeContainer]
    let sprite: Sprite
  
   
    struct Ability: Codable, Equatable {
        let name: String
    }
    
//    struct Abilities: Codable, Equatable {
//           let ability: Ability
//       }
    
    struct Names: Codable, Equatable {
        let name: String
    }
    
    struct Name: Codable, Equatable {
        let name: Names
    }
    
    struct Types: Codable, Equatable {
        let name: String
    }
    
    struct TypeContainer: Codable, Equatable {
        let name: Types
    }
    
    struct Sprite: Codable, Equatable {
        let  front_shiny: String
    }
    
    
    
}

