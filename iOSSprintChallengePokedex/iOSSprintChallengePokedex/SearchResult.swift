//
//  SearchResult.swift
//  iOSSprintChallengePokedex
//
//  Created by denis cedeno on 11/9/19.
//  Copyright © 2019 DenCedeno Co. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let name: String?
    let id: Int?
    let types: String?
    let abilities: String?
    let sprite: String?
}
