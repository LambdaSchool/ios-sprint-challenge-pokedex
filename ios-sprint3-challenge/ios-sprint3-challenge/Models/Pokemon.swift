//
//  Pokemon.swift
//  ios-sprint3-challenge
//
//  Created by De MicheliStefano on 10.08.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    
    let name: String
    let identifier: String
    let abilities: [String]
    let types: [String]
    
}
