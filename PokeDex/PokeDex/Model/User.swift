//
//  User.swift
//  PokeDex
//
//  Created by William Chen on 9/6/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation

struct UserResults: Decodable{
    let results: [User]
}


struct User: Decodable {
    var name: String
    var image: URL
}
