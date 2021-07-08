//
//  Model.swift
//  Pokemon
//
//  Created by Yvette Zhukovsky on 10/26/18.
//  Copyright © 2018 Yvette Zhukovsky. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [AbilityElement]
    let sprites: [String:String?]
    let types: [TypeElement]
    
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case abilities
        case sprites
        case types
        
    }
}

struct AbilityElement: Codable {
    let isHidden: Bool
    let slot: Int
    let ability: TypeClass
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, ability
    }
}

struct TypeClass: Codable {
    let name: String
    let url: String
}


struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}

