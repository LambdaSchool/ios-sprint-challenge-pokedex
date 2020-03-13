//
//  Type.swift
//  Pokedex
//
//  Created by Karen Rodriguez on 3/13/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

struct Type: Codable, Equatable {
    let type: TypeDetail
    
    struct TypeDetail: Codable, Equatable {
        let name: String
    }
}
